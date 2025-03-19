<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AccessLog extends Model
{
    protected $fillable = ['employee_id', 'access_time', 'access_granted'];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
}
