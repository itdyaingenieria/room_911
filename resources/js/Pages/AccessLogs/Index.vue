<template>

    <Head title="Access Logs" />
    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Access Logs
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">

                        <!-- Filters -->
                        <div class="flex flex-wrap items-end gap-4 mb-6">
                            <!-- Filter by employee -->
                            <div class="flex-1">
                                <label class="block text-gray-700 text-sm font-bold mb-2">Employee</label>
                                <select v-model="filters.employee_id"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                    <option value="">All Employees</option>
                                    <option v-for="employee in employees" :key="employee.id" :value="employee.id">
                                        👤{{ employee.first_name }} {{ employee.last_name }} ({{ employee.identification
                                        }})
                                    </option>
                                </select>
                            </div>

                            <!-- Filter by start date -->
                            <div class="flex-1">
                                <label class="block text-gray-700 text-sm font-bold mb-2">Initial access
                                    date</label>
                                <input type="date" v-model="filters.startDate"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
                            </div>

                            <!-- Filter by end date -->
                            <div class="flex-1">
                                <label class="block text-gray-700 text-sm font-bold mb-2">Final access
                                    date</label>
                                <input type="date" v-model="filters.endDate"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
                            </div>

                            <!-- Filter and Clear Filter buttons -->
                            <div class="flex items-end gap-2">
                                <button @click="applyFilters"
                                    class="flex items-center gap-1 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                                    <FunnelIcon class="w-4 h-4" /> Filter
                                </button>
                                <button @click="clearFilters"
                                    class="flex items-center gap-1 bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                                    <XMarkIcon class="w-5 h-5" /> Clear Filter
                                </button>
                            </div>
                        </div>

                        <!-- Líne -->
                        <hr class="my-6 border-gray-400" />

                        <!-- Table of access logs -->
                        <table class="min-w-full bg-white">
                            <thead>
                                <tr>
                                    <th class="py-2 px-4 border-b">ID</th>
                                    <th class="py-2 px-4 border-b">Employee</th>
                                    <th class="py-2 px-4 border-b">Employee Id</th>
                                    <th class="py-2 px-4 border-b">Access Time</th>
                                    <th class="py-2 px-4 border-b">Access Granted</th>
                                    <th class="py-2 px-4 border-b">Created At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="log in accessLogs.data" :key="log.id">
                                    <td class="py-2 px-4 border-b">{{ log.id }}</td>
                                    <td class="py-2 px-4 border-b">
                                        {{ log.employee?.first_name }} {{ log.employee?.last_name }}
                                    </td>
                                    <td class="py-2 px-4 border-b">{{ log.employee?.identification }}</td>
                                    <td class="py-2 px-4 border-b">{{ log.access_time }}</td>
                                    <td class="py-2 px-4 border-b">{{ log.access_granted ? "✅ Yes" : "❌ No" }}</td>
                                    <td class="py-2 px-4 border-b">{{ log.created_at }}</td>
                                </tr>
                            </tbody>
                        </table>

                        <!-- Pagination -->
                        <div class="mt-4 flex justify-between items-center">
                            <div>
                                <span class="text-sm text-gray-700">
                                    Showing {{ accessLogs.from }} to {{ accessLogs.to }} of {{ accessLogs.total }}
                                    entries
                                </span>
                            </div>
                            <div class="flex space-x-2">
                                <button v-for="link in accessLogs.links" :key="link.label" @click="goToPage(link.url)"
                                    :disabled="!link.url" class="px-4 py-2 rounded-md" :class="{
                                        'bg-blue-500 text-white': link.active,
                                        'bg-gray-200 text-gray-700': !link.active,
                                        'opacity-50 cursor-not-allowed': !link.url
                                    }">
                                    <span v-html="link.label"></span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<script setup>
import { ref } from "vue";
import { Head, router } from "@inertiajs/vue3";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { FunnelIcon, XMarkIcon } from "@heroicons/vue/24/solid";

const props = defineProps({
    accessLogs: Object,
    employees: Array,
});

// Filters
const filters = ref({
    employee_id: "",
    startDate: "",
    endDate: "",
});

// Apply filters
const applyFilters = () => {
    router.get(route("access-logs.index"), {
        employee_id: filters.value.employee_id,
        startDate: filters.value.startDate,
        endDate: filters.value.endDate,
        page: 1, // Reset to the first page when filters are applied
    }, {
        preserveState: true,
        replace: true,
    });
};

// Clear filters
const clearFilters = () => {
    filters.value = {
        employee_id: "",
        startDate: "",
        endDate: "",
    };
    applyFilters(); // Re-fetch data without filters
};

// Navigate to a specific page
const goToPage = (url) => {
    if (url) {
        const params = new URLSearchParams(url.split('?')[1]); // Extract parameters from the URL
        const page = params.get('page') || 1; // Get the current page

        router.get(route("access-logs.index"), {
            employee_id: filters.value.employee_id,
            startDate: filters.value.startDate,
            endDate: filters.value.endDate,
            page: page, // Maintain pagination with filters
        }, {
            preserveState: true,
            replace: true,
        });
    }
};
</script>