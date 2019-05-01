import { Component, OnInit } from '@angular/core';
import {Router} from "@angular/router";
import {UserService} from "../service/user.service";
import {User} from "../model/user.model";
import { Pipe, PipeTransform } from '@angular/core';
import {CommonModule} from "@angular/common";
import { FilterPipe } from 'ngx-filter-pipe';


@Component({
  selector: 'app-list-user',
  templateUrl: './list-task.component.html',
  styleUrls: ['./list-task.component.css']
   
})
export class ListUserComponent implements OnInit {

public minDate: Date = new Date ("05/07/2017");
    public maxDate: Date = new Date ("05/27/2030");
    private k: Date = new Date ("05/16/2017");

  userFilter: any = { task: '',parent_task:'',start_date:'',end_date:'',priority:''};
   
  users: User[];

  constructor(private router: Router, private userService: UserService,private filterPipe: FilterPipe) { }

  ngOnInit() {
    this.userService.getUsers()
      .subscribe( data => {
        this.users = data;
      });
  }

  deleteUser(user: User): void {
    this.userService.deleteUser(user.task_id)
      .subscribe( data => {
        this.users = this.users.filter(u => u !== user);
      })
  };
  
  finishTask(user: User): void {
    this.userService.finishTask(user.task_id)
      .subscribe( data => {
	  this.userService.getUsers()
      .subscribe( data => {
        this.users = data;
      });
      })
	  
  };
  

  editUser(user: User): void {
    localStorage.removeItem("editUserId");
    localStorage.setItem("editUserId", user.task_id.toString());
    this.router.navigate(['edit-user']);
  };

  addUser(): void {
    this.router.navigate(['add-user']);
  };
}
