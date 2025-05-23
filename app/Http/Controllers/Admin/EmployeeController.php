<?php

namespace App\Http\Controllers\Admin;

use Inertia\Inertia;
use App\Models\Employee;
use App\Models\Department;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\EmployeesImport;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class EmployeeController extends Controller
{
    public function index(Request $request)
    {
        $query = Employee::with('department')
            ->withCount('accessLogs');

        if ($request->search) {
            $query->where(function ($q) use ($request) {
                $q->where('first_name', 'like', "%{$request->search}%")
                    ->orWhere('last_name', 'like', "%{$request->search}%")
                    ->orWhere('identification', 'like', "%{$request->search}%");
            });
        }

        if ($request->department) {
            $query->where('department_id', $request->department);
        }

        $employees = $query->paginate(8);

        Log::info('Filtered Employees: ' . json_encode($employees->items()));

        $departments = Department::all();

        return Inertia::render('Employees/Index', [
            'employees'   => $employees,
            'departments' => $departments,
        ]);
    }

    public function create()
    {
        $departments = Department::all(); // Get all departments for the select input

        return Inertia::render('Employees/Create', [
            'departments' => $departments,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'first_name' => 'required|max:255',
            'last_name' => 'required|max:255',
            'identification' => 'required|unique:employees|max:255',
            'department_id' => 'required|exists:departments,id',
            'has_access' => 'boolean',
        ]);

        Employee::create($request->all());

        return redirect()->route('employees.index');
    }

    public function edit(Employee $employee)
    {
        $departments = Department::all(); // get all departments for the select input
        return Inertia::render('Employees/Edit', [
            'employee'      => $employee,
            'departments'   => $departments,
        ]);
    }

    public function editAxios(Employee $employee)
    {
        $departments = Department::all(); // get all departments for the select input
        return Inertia::render('Employees/EditAxios', [
            'employee'      => $employee,
            'departments'   => $departments,
        ]);
    }

    public function update(Request $request, Employee $employee)
    {
        $request->validate([
            'first_name'     => 'required|max:255',
            'last_name'      => 'required|max:255',
            'identification' => 'required|unique:employees,identification,' . $employee->id,
            'department_id'  => 'required|exists:departments,id',
            'has_access'     => 'boolean',
        ]);

        $employee->update($request->all());

        if ($request->header('X-Inertia')) {
            return redirect()->route('employees.index');
        } else {
            return response()->json([
                'message' => 'Employee updated successfully',
                'employee' => $employee,
            ]);
        }
    }

    public function destroy(Employee $employee)
    {
        $employee->delete();
        return redirect()->route('employees.index');
    }

    // Upload CSV file
    public function uploadCSV(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'csv_file'      => 'required|file|mimes:csv,txt',
            'department_id' => 'required|exists:departments,id',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Invalid file or department.'], 422);
        }

        try {
            Excel::import(new EmployeesImport($request->department_id), $request->file('csv_file'));
            return redirect()->route('employees.index');
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error uploading CSV: ' . $e->getMessage()], 500);
        }
    }
}
