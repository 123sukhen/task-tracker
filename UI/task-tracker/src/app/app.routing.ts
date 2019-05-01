import { RouterModule, Routes } from '@angular/router';
import {LoginComponent} from "./login/login.component";
import {AddUserComponent} from "./add-task/add-task.component";
import {ListUserComponent} from "./list-task/list-task.component";
import {EditUserComponent} from "./edit-task/edit-task.component";

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'add-user', component: AddUserComponent },
  { path: 'list-user', component: ListUserComponent },
  { path: 'edit-user', component: EditUserComponent },
  {path : '', component : LoginComponent}
];

export const routing = RouterModule.forRoot(routes);
