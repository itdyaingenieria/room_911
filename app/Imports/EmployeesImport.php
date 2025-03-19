<?php

namespace App\Imports;

use App\Models\Employee;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class EmployeesImport implements ToModel, WithHeadingRow
{
    protected $departmentId;

    public function __construct($departmentId)
    {
        $this->departmentId = $departmentId;
    }

    public function model(array $row)
    {
        return new Employee([
            'first_name'     => $row['first_name'],
            'last_name'      => $row['last_name'],
            'identification' => $row['identification'],
            'department_id'  => $this->departmentId,
            'has_access'     => $row['has_access'] ?? false,
        ]);
    }
}
