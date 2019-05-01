import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {User} from "../model/user.model";

@Injectable()
export class UserService {
  constructor(private http: HttpClient) { }
  baseUrl: string = 'http://localhost:8080/task-tracker/users';

  getUsers() {
  
    return this.http.get<User[]>(this.baseUrl);
  }

  getUserById(task_id: number) {
    return this.http.get<User>(this.baseUrl + '/' + task_id);
  }

  createUser(user: User) {
    return this.http.post(this.baseUrl, user);
  }

  updateUser(user: User) {
    return this.http.put(this.baseUrl + '/' + user.task_id,user);
  }

  deleteUser(task_id: number) {
    return this.http.delete(this.baseUrl + '/delete/' + task_id);
  }
  finishTask(task_id: number) {
    return this.http.delete(this.baseUrl + '/finish/' + task_id);
  }
  
  
  
}
