<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Employee;
use App\Models\AccessLog;
use App\Models\Department;
use Carbon\Carbon;

class DashboardController extends Controller
{

    public function index()
    {
        $totalEmployees      = Employee::count();

        $accessAttemptsToday = AccessLog::whereDate('access_time', Carbon::today())->count();

        $totalDepartments    = Department::count();

        return Inertia::render('Dashboard', [
            'totalEmployees'        => $totalEmployees,
            'accessAttemptsToday'   => $accessAttemptsToday,
            'totalDepartments'      => $totalDepartments,
        ]);
    }
}
