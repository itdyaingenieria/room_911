<template>
    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Edit Employee with Axios
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        <form @submit.prevent="submit">
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="first_name">
                                    First Name
                                </label>
                                <input v-model="form.first_name" type="text"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="first_name" required />
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="last_name">
                                    Last Name
                                </label>
                                <input v-model="form.last_name" type="text"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="last_name" required />
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="identification">
                                    Identification
                                </label>
                                <input v-model="form.identification" type="text"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="identification" required />
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="department_id">
                                    Department
                                </label>
                                <select v-model="form.department_id"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="department_id" required>
                                    <option value="">Select a Department</option>
                                    <option v-for="department in departments" :key="department.id"
                                        :value="department.id">
                                        {{ department.name }}
                                    </option>
                                </select>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="has_access">
                                    Has Access
                                </label>
                                <input v-model="form.has_access" type="checkbox"
                                    class="form-checkbox h-5 w-5 text-blue-600" id="has_access" />
                            </div>
                            <div class="flex items-center justify-between">
                                <button type="submit"
                                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                                    Update
                                </button>
                                <button type="button" @click="cancel"
                                    class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                                    Cancel
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'; // Importa el layout
import axios from 'axios';
import { useForm } from '@inertiajs/vue3';

const props = defineProps({
    employee: {
        type: Object,
        required: true,
    },
    departments: {
        type: Array,
        required: true,
    },
});

const form = useForm({
    first_name: props.employee.first_name,
    last_name: props.employee.last_name,
    identification: props.employee.identification,
    department_id: props.employee.department_id,
    has_access: Boolean(props.employee.has_access),
});

const submit = async () => {
    const employeeId = props.employee.id;
    const url = `/employees/${employeeId}`;

    try {
        const response = await axios.put(url, form);
        console.log(response.data);
        alert('Employee updated successfully!');
        window.location.href = '/employees';
    } catch (error) {
        if (error.response) {
            alert('Error updating employee: ' + error.response.data.message);
        } else {
            alert('Error updating employee: ' + error.message);
        }
    }
};

const cancel = () => {
    window.location.href = '/employees';
};
</script>