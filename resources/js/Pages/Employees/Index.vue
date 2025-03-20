<template>

    <Head title="Employees" />
    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Employees
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">

                        <div class="flex flex-wrap items-end gap-4 mb-6">
                            <!-- search -->
                            <div class="flex-1">
                                <label class="block text-gray-700 text-sm font-bold mb-2">Search</label>
                                <input v-model="search" type="text" placeholder="🔍Search by name or ID"
                                    class="shadow appearance-none border rounded-full w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
                            </div>

                            <!-- Filter by department -->
                            <div class="flex-1">
                                <label class="block text-gray-700 text-sm font-bold mb-2">Department</label>
                                <select v-model="selectedDepartment"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                    <option value="">Filter by deparment</option>
                                    <option v-for="department in departments" :key="department.id"
                                        :value="department.id">
                                        🏢{{ department.name }}
                                    </option>
                                </select>
                            </div>

                            <!-- Buttons for filter -->
                            <div class="flex items-end gap-2 ">
                                <button @click="applyFilters"
                                    class="flex items-center gap-1 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                                    <FunnelIcon class="w-4 h-4" /> Filter
                                </button>
                                <button @click="clearFilters"
                                    class="flex items-center gap-1 bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                                    <XMarkIcon class="w-5 h-5" /> Clear filter
                                </button>
                            </div>
                        </div>

                        <!-- Líne -->
                        <hr class="my-6 border-gray-400" />

                        <!-- Button New Employee -->
                        <div class="mb-6 flex justify-end  space-x-2">
                            <button @click="createEmployee"
                                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline"
                                title="Create a new employee">
                                New Employee
                            </button>
                            <button @click="openCSVModal"
                                class="flex items-center gap-2 bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline"
                                title="Upload a CSV file">
                                <ArrowUpTrayIcon class="w-5 h-5" /> Upload CSV
                            </button>
                        </div>

                        <!-- Modal upload CSV -->
                        <div v-if="showCSVModal"
                            class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                            <div class="bg-white p-6 rounded-lg w-1/3">
                                <h3 class="text-lg font-bold mb-4">Upload CSV File</h3>
                                <form @submit.prevent="uploadCSV">
                                    <div class="mb-4">
                                        <label class="block text-gray-700 text-sm font-bold mb-2" for="department_id">
                                            Department
                                        </label>
                                        <select v-model="csvDepartmentId"
                                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                            id="department_id" required>
                                            <option value="">🏚️Select a Department</option>
                                            <option v-for="department in departments" :key="department.id"
                                                :value="department.id">
                                                🏢{{ department.name }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="mb-4">
                                        <label class="block text-gray-700 text-sm font-bold mb-2" for="csv_file">
                                            CSV File
                                        </label>
                                        <input type="file" ref="csvFileInput" accept=".csv"
                                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                            required />
                                    </div>

                                    <div class="flex justify-end space-x-4">
                                        <button type="button" @click="closeCSVModal"
                                            class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                                            ❌ Cancel
                                        </button>
                                        <button type="submit"
                                            class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                                            ⬆️Upload
                                        </button>
                                    </div>

                                </form>
                            </div>
                        </div>

                        <!-- Global load indicator-->
                        <div v-if="isLoading"
                            class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                            <div class="bg-white p-6 rounded-lg">
                                <p class="text-lg font-bold">Uploading CSV...</p>
                                <svg class="animate-spin h-8 w-8 text-blue-500 mx-auto mt-4"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                        stroke-width="4">
                                    </circle>
                                    <path class="opacity-75" fill="currentColor"
                                        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                                    </path>
                                </svg>
                            </div>
                        </div>

                        <!-- Table of employees -->
                        <table class="min-w-full bg-white">
                            <thead>
                                <tr>
                                    <th class="py-2 px-4 border-b">Employee ID</th>
                                    <th class="py-2 px-4 border-b">First Name</th>
                                    <th class="py-2 px-4 border-b">Last Name</th>
                                    <th class="py-2 px-4 border-b">Department</th>
                                    <th class="py-2 px-4 border-b">Has Access</th>
                                    <th class="py-2 px-4 border-b">Total Access</th>
                                    <th class="py-2 px-4 border-b">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="employee in filteredEmployees" :key="employee.id">
                                    <td class="py-2 px-4 border-b">{{ employee.identification }}</td>
                                    <td class="py-2 px-4 border-b">{{ employee.first_name }}</td>
                                    <td class="py-2 px-4 border-b">{{ employee.last_name }}</td>
                                    <td class="py-2 px-4 border-b">{{ employee.department.name }}</td>
                                    <td class="py-2 px-4 border-b">{{ employee.has_access ? 'Yes' : 'No' }}</td>
                                    <td class="py-2 px-4 border-b">{{ employee.access_logs_count }}</td>
                                    <td class="py-2 px-4 border-b">
                                        <div class="flex space-x-2">
                                            <button @click="editEmployee(employee.id)"
                                                class="flex items-center gap-2 bg-blue-500 hover:bg-blue-700 text-white  py-1 px-3 rounded-xl">
                                                <ArrowPathIcon class="w-5 h-5" /> Update
                                            </button>
                                            <button @click="editAxiosEmployee(employee.id)"
                                                class="flex items-center gap-2 bg-blue-500 hover:bg-blue-700 text-white  py-1 px-3 rounded-xl">
                                                <ArrowPathIcon class="w-5 h-5" /> UpdateAxios
                                            </button>

                                            <button @click="deleteEmployee(employee.id)"
                                                class="flex items-center gap-2 bg-red-500 hover:bg-red-700 text-white py-1 px-3 rounded-xl">
                                                <TrashIcon class="w-5 h-5" /> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <!-- Pagination -->
                        <div class="mt-4 flex justify-between items-center">
                            <div>
                                <span class="text-sm text-gray-700">
                                    Showing {{ employees.from }} to {{ employees.to }} of {{ employees.total }} entries
                                </span>
                            </div>
                            <div class="flex space-x-2">
                                <button v-for="link in employees.links" :key="link.label" @click="goToPage(link.url)"
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
import { ref, computed } from 'vue';
import { Head, router } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { ArrowPathIcon, TrashIcon, FunnelIcon, XMarkIcon, ArrowUpTrayIcon } from '@heroicons/vue/24/solid';

const props = defineProps({
    employees: Object,
    departments: Array,
});

const search = ref('');
const selectedDepartment = ref('');
const currentPage = ref(props.employees.current_page || 1);

const showCSVModal = ref(false);
const csvDepartmentId = ref('');
const csvFileInput = ref(null);
const isLoading = ref(false); // Loading indicator

const openCSVModal = () => {
    showCSVModal.value = true;
};

const closeCSVModal = () => {
    showCSVModal.value = false;
    csvDepartmentId.value = '';
    if (csvFileInput.value) {
        csvFileInput.value.value = ''; // clear the file input
    }
};

const uploadCSV = async () => {
    const file = csvFileInput.value.files[0];
    if (!file || !csvDepartmentId.value) {
        alert('Please select a department and a CSV file.');
        return;
    }

    isLoading.value = true; // Show loading indicator

    const formData = new FormData();
    formData.append('csv_file', file);
    formData.append('department_id', csvDepartmentId.value);

    try {
        router.post('/employees/upload-csv', formData, {
            onSuccess: () => {
                alert('Employees uploaded successfully!');
                closeCSVModal();
                router.reload(); // reload the page to show the new employees
            },
            onError: (errors) => {
                alert('Error uploading CSV: ' + (errors.message || 'Unknown error'));
            },
            onFinish: () => {
                isLoading.value = false; // Hide loading indicator
            },
        });
    } catch (error) {
        alert('Error uploading CSV: ' + error.message);
    }
};

// Filter employees
const filteredEmployees = computed(() => {
    return props.employees.data.filter(employee => {
        const matchesSearch = employee.first_name.toLowerCase().includes(search.value.toLowerCase()) ||
            employee.last_name.toLowerCase().includes(search.value.toLowerCase()) ||
            employee.identification.includes(search.value);

        const matchesDepartment = selectedDepartment.value ? employee.department_id === selectedDepartment.value : true;


        return matchesSearch && matchesDepartment;
    });
});

const applyFilters = () => {
    router.get('/employees', {
        search: search.value,
        department: selectedDepartment.value,
        startDate: startDate.value,
        endDate: endDate.value,
        page: currentPage.value, // Current page
    }, {
        preserveState: true, // Prevents Inertia from reloading the entire page
        replace: true, // Update URL without adding history
    });
};

// Clear filters
const clearFilters = () => {
    search.value = '';
    selectedDepartment.value = '';
    startDate.value = '';
    endDate.value = '';
    applyFilters(); // Apply empty filters to reload the full list
};

// Navigate to the employee creation page
const createEmployee = () => {
    router.visit('/employees/create');
};

const goToPage = (url) => {
    if (url) {
        const params = new URLSearchParams(url.split('?')[1]); // Extracts parameters from the URL
        currentPage.value = params.get('page') || 1; // Gets the current page

        router.get('/employees', {
            search: search.value,
            department: selectedDepartment.value,
            page: currentPage.value, // Maintain pagination with filters
        }, {
            preserveState: true,
            replace: true,
        });
    }
};


// Navigate to the employee editing page
const editEmployee = (id) => {
    router.visit(`/employees/${id}/edit`);
};

// Navigate to the employee editing page
const editAxiosEmployee = (id) => {
    router.visit(`/employees/${id}/edit-axios`);
};

// Delete employee
const deleteEmployee = (id) => {
    if (confirm('Are you sure you want to delete this employee?')) {
        router.delete(`/employees/${id}`); // call url of the route
    }
};
</script>