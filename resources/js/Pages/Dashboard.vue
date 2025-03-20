<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
</script>

<template>

    <Head title="Dashboard" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="text-xl font-semibold leading-tight text-gray-800">
                ROOM_911 - Access Control
            </h2>
        </template>

        <div class="py-12">
            <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                    <div class="p-6 text-gray-900">
                        <!-- System Presentation -->
                        <div class="text-center">
                            <h1 class="text-3xl font-bold text-blue-600">
                                💊 Welcome to the ROOM_911 System
                            </h1>
                            <p class="mt-4 text-lg text-gray-700">
                                Access control for personnel in the high-cost drug production area.
                            </p>
                        </div>

                        <!-- Statistics or Relevant Information -->
                        <div class="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
                            <!-- Card 1: Registered Employees -->
                            <div class="rounded-lg bg-gray-50 p-6 shadow">
                                <h3 class="text-lg font-semibold text-gray-800">
                                    Registered Employees
                                </h3>
                                <p class="mt-2 text-2xl font-bold text-blue-600">
                                    150
                                </p>
                                <p class="mt-2 text-sm text-gray-600">
                                    Total employees with access to ROOM_911.
                                </p>
                            </div>

                            <!-- Card 2: Access Attempts Today -->
                            <div class="rounded-lg bg-gray-50 p-6 shadow">
                                <h3 class="text-lg font-semibold text-gray-800">
                                    Access Attempts Today
                                </h3>
                                <p class="mt-2 text-2xl font-bold text-blue-600">
                                    25
                                </p>
                                <p class="mt-2 text-sm text-gray-600">
                                    Access attempts registered today.
                                </p>
                            </div>

                            <!-- Card 3: Departments -->
                            <div class="rounded-lg bg-gray-50 p-6 shadow">
                                <h3 class="text-lg font-semibold text-gray-800">
                                    Departments
                                </h3>
                                <p class="mt-2 text-2xl font-bold text-blue-600">
                                    5
                                </p>
                                <p class="mt-2 text-sm text-gray-600">
                                    Active departments in the system.
                                </p>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="mt-8 text-center">
                            <h2 class="text-xl font-semibold text-gray-800">
                                Quick Actions
                            </h2>
                            <div class="mt-4 flex justify-center space-x-4">
                                <a :href="route('employees.index')"
                                    class="rounded-xl bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700">
                                    🙋 Manage Employees
                                </a>
                                <a :href="route('departments.index')"
                                    class="rounded-xl bg-gray-600 px-4 py-2 text-sm font-medium text-white hover:bg-gray-700">
                                    🏢 Manage Departments
                                </a>
                                <a :href="route('access-logs.index')"
                                    class="rounded-xl bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700">
                                    🔑 View Access Logs
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>