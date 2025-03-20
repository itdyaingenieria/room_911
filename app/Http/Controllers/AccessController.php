<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Employee;
use App\Models\AccessLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AccessController extends Controller
{
    public function showAccessSimulator()
    {
        return Inertia::render('AccessSimulator/Index');
    }

    public function validateAccess(Request $request)
    {
        $request->validate([
            'employeeId' => 'required|string|exists:employees,identification',
        ]);

        $employeeId = $request->input('employeeId');
        $employee   = Employee::where('identification', $employeeId)->first();

        // if null or not exist
        if (!$employee) {
            return response()->json(['success' => false, 'message' => 'Employee not found'], 404);
        }

        Log::info('Employee Name: ' . $employee->first_name . ' HaveAccess: ' . $employee->has_access);

        if ($employee && $employee->has_access) {
            AccessLog::create([
                'employee_id' => $employee->id,
                'access_time' => now(),
                'access_granted' => true,
            ]);

            $request->session()->put('employeeId', $employeeId);

            return response()->json(['success' => true, 'message' => 'Access granted'], 200);
        } else {
            AccessLog::create([
                'employee_id' => $employee->id ?? null,
                'access_time' => now(),
                'access_granted' => false,
            ]);

            Log::info('Access denied for employee: ' . $employeeId);
            return response()->json(['success' => false, 'message' => 'Access denied, You do not have permission'], 401);
        }
    }

    public function showDashboard()
    {
        return Inertia::render('AccessSimulator/Dashboard');
    }

    public function logout(Request $request)
    {
        $request->session()->forget('employeeId');
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('validate-access')->with('success', 'You have been logged out.');
    }
}
