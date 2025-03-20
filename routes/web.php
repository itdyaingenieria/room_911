<?php

use App\Http\Controllers\Admin\EmployeeController;
use App\Http\Controllers\Admin\DepartmentController;
use App\Http\Controllers\Admin\AccessLogController;
use App\Http\Controllers\Auth\AdminAuthController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\AccessController;

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin'          => Route::has('login'),
        //'canRegister'       => Route::has('register'),
        'canValidateAccess' => Route::has('validate-access'),
        'laravelVersion'    => Application::VERSION,
        'phpVersion'        => PHP_VERSION,
    ]);
});

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// routes departments
Route::middleware('auth')->group(function () {
    Route::get('/departments', [DepartmentController::class, 'index'])->name('departments.index');
    Route::get('/departments/create', [DepartmentController::class, 'create'])->name('departments.create');
    Route::post('/departments', [DepartmentController::class, 'store'])->name('departments.store');
    Route::get('/departments/{department}/edit', [DepartmentController::class, 'edit'])->name('departments.edit');
    Route::put('/departments/{department}', [DepartmentController::class, 'update'])->name('departments.update');
    Route::delete('/departments/{department}', [DepartmentController::class, 'destroy'])->name('departments.destroy');
});

// routes employees
Route::middleware('auth')->group(function () {
    Route::get('/employees', [EmployeeController::class, 'index'])->name('employees.index');
    Route::get('/employees/create', [EmployeeController::class, 'create'])->name('employees.create');
    Route::post('/employees', [EmployeeController::class, 'store'])->name('employees.store');
    Route::get('/employees/{employee}/edit', [EmployeeController::class, 'edit'])->name('employees.edit');
    Route::get('/employees/{employee}/edit-axios', [EmployeeController::class, 'editAxios'])->name('employees.editAxios');
    Route::put('/employees/{employee}', [EmployeeController::class, 'update'])->name('employees.update');
    Route::delete('/employees/{employee}', [EmployeeController::class, 'destroy'])->name('employees.destroy');
    Route::post('/employees/upload-csv', [EmployeeController::class, 'uploadCSV'])->name('employees.upload-csv');
});

Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('access-logs', AccessLogController::class);
});


// Routes for the access simulator
Route::get('/validate-access', [AccessController::class, 'showAccessSimulator'])->name('validate-access');
Route::post('/validate-access', [AccessController::class, 'validateAccess']);
Route::middleware(['access.valid'])->group(function () {
    Route::get('/access-simulator/dashboard', [AccessController::class, 'showDashboard'])
        ->name('access-simulator.dashboard');
    Route::post('/access-simulator/logout-access-simulator', [AccessController::class, 'logout'])->name('logout-access-simulator');
});

require __DIR__ . '/auth.php';
