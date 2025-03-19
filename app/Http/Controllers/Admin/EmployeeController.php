<?php

namespace App\Http\Controllers\Admin;

use Inertia\Inertia;
use App\Models\Employee;
use App\Models\Department;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class EmployeeController extends Controller
{
    public function index(Request $request)
    {
        $query = Employee::with('department');

        if ($request->search) {
            $query->where('first_name', 'like', "%{$request->search}%")
                ->orWhere('last_name', 'like', "%{$request->search}%")
                ->orWhere('identification', 'like', "%{$request->search}%");
        }

        if ($request->department) {
            $query->where('department_id', $request->department);
        }

        if ($request->startDate && $request->endDate) {
            $query->whereBetween('access_date', [$request->startDate, $request->endDate]);
        }

        $employees = $query->paginate(5);

        $departments = Department::all();

        return Inertia::render('Employees/Index', [
            'employees' => $employees,
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
}
