<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Access Logs Report</title>
    <!-- Font-Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
        integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
        crossorigin="anonymous" />

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            font-size: 12px;
            line-height: 1.1;
            margin: 0;
            padding: 0px 2px 2px;
            background-color: #ffffff;
            color: #333;
        }

        h1 {
            text-align: left;
            font-size: 18px;
            color: #1E3A8A;
            margin-bottom: 3px;
            font-weight: bold;
        }

        h2,
        h3 {
            text-align: center;
            color: #1E3A8A;
            margin-bottom: 3px;
        }

        h2 {
            font-size: 14px;
            font-weight: 600;
        }

        h3 {
            font-size: 11px;
            margin-bottom: 3px;
        }

        p {
            font-size: 8px;
            margin: 2px 0;
        }

        .signature-text {
            font-size: 10px;
            margin: 2px 0;
        }

        strong {
            color: #1E3A8A;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0;
            margin-bottom: 5px;
        }

        th,
        td {
            padding: 2px 5px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
            font-size: 12px;
        }

        th {
            text-align: center !important;
            background-color: #1E3A8A;
            color: #fff;
            font-weight: 600;
        }

        td {
            background-color: #ffffff;
            color: #333;
        }

        /* Custom Borders */
        .bordered-cell-left {
            border-left: 1px solid #d1d5db;
        }

        .cell-align-right {
            text-align: right !important;
        }

        tr:nth-child(even) td {
            background-color: #f9fafb;
        }

        /* Column Widths */
        .col-1 {
            width: 10%;
            text-align: center;
            font-weight: bold;
            color: #000;
            vertical-align: middle;
        }

        .col-2 {
            width: 30%;
        }

        .col-3 {
            width: 60%;
        }

        /* Vertical Column Title */
        .vertical-title {
            transform: rotate(-45deg);
            border-right: 1px dashed #b0b0b0;
            writing-mode: vertical-rl;
            vertical-align: middle;
        }

        /* Dashed Bottom Border */
        .discontinuous-border {
            border-bottom: 1px dashed #b0b0b0 !important;
        }

        /* Page Settings */
        @page {
            margin: 0;
            padding: 0;
            size: A4;
        }

        body {
            margin: 20mm;
        }

        .additional-info {
            font-size: 10px;
            color: #4b5563;
            padding-top: 3px;
        }

        /* Logo Style */
        .logo {
            width: 280px;
            height: 40px;
            margin-right: 15px;
        }

        /* Company Info Style */
        td.company-info {
            text-align: center;
            padding: 15px;
            background: linear-gradient(to bottom right, #1E3A8A, #ffffff);
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Main Title */
        .company-info .main-title {
            font-size: 24px;
            color: #1E3A8A;
            font-weight: bold;
            margin: 0;
        }

        /* Subtitle */
        .company-info .sub-title {
            font-size: 14px;
            color: #333;
            margin: 5px 0;
        }

        /* NIT */
        .company-info .nit {
            font-size: 12px;
            color: #4b5563;
            margin: 0;
        }

        /* Final Section */
        .final-section {
            position: absolute;
            bottom: 20mm;
            width: 100%;
            text-align: left;
            font-size: 12px;
        }

        .final-section div {
            display: inline-block;
            text-align: left;
            width: 35%;
            margin: 0 15px;
        }

        .final-section hr {
            margin-top: 5px;
            border: none;
            border-top: 1px solid black;
            width: 100%;
        }

        .final-section p {
            margin-top: 4px;
            margin-bottom: 4px;
        }

        /* Footer */
        .footer {
            position: absolute;
            bottom: 5mm;
            width: calc(100% - 5mm);
            text-align: left;
            font-size: 8px;
            color: #4b5563;
            padding-top: 5px;
            border-top: 0.5px solid #b0b0b0;
            box-sizing: border-box;
        }
    </style>
</head>

<body>

    <table>
        <tr>
            <td class="company-info">
                <img src="{{ public_path('images/logo.png') }}" class="logo" />
                <div class="nit">Tax ID: 22222203-2</div>
            </td>
            <td>
                <h1>Access Logs Report</h1>
                <div class="sub-title">Report Date: {{ now()->format('Y-m-d H:i:s') }}</div>
                @if (isset($filters['startDate']) || isset($filters['endDate']))
                <div class="sub-title">
                    @if (isset($filters['startDate']))
                    <strong>Initial Access Date:</strong> {{ $filters['startDate'] }}
                    @endif
                    @if (isset($filters['endDate']))
                    <strong>Final Access Date:</strong> {{ $filters['endDate'] }}
                    @endif
                </div>
                @endif
            </td>
        </tr>
    </table>

    <!-- Access Logs Table -->
    <div class="section">
        <h3>Access Logs</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Employee</th>
                    <th>Employee ID</th>
                    <th>Access Time</th>
                    <th>Access Granted</th>
                    <th>Created At</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($accessLogs as $log)
                <tr>
                    <td>{{ $log->id }}</td>
                    <td>{{ $log->employee->first_name }} {{ $log->employee->last_name }}</td>
                    <td>{{ $log->employee->identification }}</td>
                    <td>{{ $log->access_time }}</td>
                    <td>{{ $log->access_granted ? "Yes" : "No" }}</td>
                    <td>{{ $log->created_at }}</td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    <!-- Final Section -->
    <div class="final-section">
        <div>
            <hr>
            <p class="signature-text">Responsible Signature</p>
        </div>
        <div>
            <hr>
            <p class="signature-text">ID #</p>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p><strong>IMPORTANT INFORMATION:</strong></p>
        <p>This document is not valid without the responsible signature and the official company seal.</p>
        <p>Document generated by <strong>room911</strong> developed by <strong>Diego Yama Andrade</strong></p>
    </div>

</body>

</html>