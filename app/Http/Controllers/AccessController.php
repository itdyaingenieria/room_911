<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Employee;
use App\Models\AccessLog;
use Illuminate\Http\Request;

class AccessController extends Controller
{
    public function showAccessSimulator()
    {
        return Inertia::render('AccessSimulator/Index');
    }

    public function validateAccess(Request $request)
    {
        $employeeId = $request->input('employeeId');

        $employee = Employee::where('identification', $employeeId)->first();

        if ($employee && $employee->has_access) {

            AccessLog::create([
                'employee_id'     => $employee->id, // id of the employee
                'access_time'     => now(),
                'access_granted'  => true,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Access granted',
            ]);
        } else {

            AccessLog::create([
                'employee_id'    => $employee->id,
                'access_time'    => now(),
                'access_granted' => false,
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Access denied',
            ]);
        }
    }
}
