<?php

namespace App\Http\Controllers\Admin;

use App\Models\AccessLog;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Inertia\Inertia;
use App\Models\Employee;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class AccessLogController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = AccessLog::with('employee:id,first_name,last_name,identification');

        Log::info('Query: ' . json_encode($query->get()));

        if ($request->employee_id) {
            $query->where('employee_id', $request->employee_id);
        }

        if ($request->startDate && $request->endDate) {
            $startDate = Carbon::parse($request->startDate)->startOfDay();
            $endDate   = Carbon::parse($request->endDate)->endOfDay();
            $query->whereBetween('access_time', [$startDate, $endDate]);
        }

        $accessLogs = $query->orderBy('access_time', 'desc')->paginate(10);
        $employees  = Employee::select('id', 'first_name', 'last_name', 'identification')->get();

        return Inertia::render('AccessLogs/Index', [
            'accessLogs' => $accessLogs,
            'employees' => $employees
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
