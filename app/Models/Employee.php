<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    protected $fillable = ['first_name', 'last_name', 'identification', 'department_id', 'has_access'];

    public function department()
    {
        return $this->belongsTo(Department::class);
    }

    public function accessLogs()
    {
        return $this->hasMany(AccessLog::class, 'employee_id', 'id');
    }
}
