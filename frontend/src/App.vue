<template>
  <div class="container">
    <header>
      <h1>Task Manager</h1>
      <p class="app-subtitle">Stay organized, focused, and productive</p>
    </header>

    <div v-if="apiError" class="alert alert-error">
      <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 10px;">
        <circle cx="12" cy="12" r="10"></circle>
        <line x1="12" y1="8" x2="12" y2="12"></line>
        <line x1="12" y1="16" x2="12.01" y2="16"></line>
      </svg>
      {{ apiError }}
    </div>

    <TaskForm 
      :isLoading="isCreating" 
      @submit="createTask" 
    />
    
    <TaskList 
      :tasks="tasks" 
      :isLoading="isLoading" 
      @delete="deleteTask" 
    />
    
    <footer class="app-footer">
      <p>© 2025 Task Manager</p>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import TaskForm from './components/TaskForm.vue';
import TaskList from './components/TaskList.vue';
import TaskService from './services/TaskService';

const tasks = ref([]);
const isLoading = ref(true);
const isCreating = ref(false);
const apiError = ref('');

// Fetch all tasks when component mounts
onMounted(async () => {
  try {
    const response = await TaskService.getTasks();
    tasks.value = response.data;
  } catch (error) {
    console.error('Error fetching tasks:', error);
    apiError.value = 'Failed to load tasks. Please refresh or try again later.';
  } finally {
    isLoading.value = false;
  }
});

const createTask = async (taskData) => {
  try {
    isCreating.value = true;
    apiError.value = '';
    
    const response = await TaskService.createTask(taskData);
    tasks.value = [response.data, ...tasks.value]; // Add to beginning of the list
  } catch (error) {
    console.error('Error creating task:', error);
    
    if (error.response && error.response.data && error.response.data.errors) {
      apiError.value = error.response.data.errors.join(', ');
    } else {
      apiError.value = 'Failed to create task. Please try again.';
    }
  } finally {
    isCreating.value = false;
  }
};

const deleteTask = async (id) => {
  try {
    apiError.value = '';
    
    await TaskService.deleteTask(id);
    tasks.value = tasks.value.filter(task => task.id !== id);
  } catch (error) {
    console.error('Error deleting task:', error);
    apiError.value = 'Failed to delete task. Please try again.';
  }
};
</script>

<style scoped>
.app-subtitle {
  color: var(--text-secondary);
  text-align: center;
  margin-top: -0.75rem;
  font-size: 1rem;
}

.app-footer {
  text-align: center;
  margin-top: 3rem;
  color: var(--text-secondary);
  font-size: 0.85rem;
}
</style>