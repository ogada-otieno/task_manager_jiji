import axios from 'axios';

const apiClient = axios.create({
  baseURL: 'http://localhost:3000/api',
  headers: {
    'Content-Type': 'application/json',
  },
});

export default {
  getTasks() {
    return apiClient.get('/tasks');
  },
  createTask(task) {
    return apiClient.post('/tasks', { task });
  },
  deleteTask(id) {
    return apiClient.delete(`/tasks/${id}`);
  },
};
