import { Component, OnInit } from '@angular/core';
import {UserService} from "../service/user.service";
import {Router} from "@angular/router";
import {User} from "../model/user.model";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {first} from "rxjs/operators";
import { Options } from 'ng5-slider';

@Component({
  selector: 'app-edit-user',
  templateUrl: './edit-task.component.html',
  styleUrls: ['./edit-task.component.css']
})
export class EditUserComponent implements OnInit {

   priority:number=0;
   options: Options = {
    floor: 0,
    ceil: 30
  };


  user: User;
  editForm: FormGroup;
  constructor(private formBuilder: FormBuilder,private router: Router, private userService: UserService) { }

  ngOnInit() {
    let userId = localStorage.getItem("editUserId");
	
    if(!userId) {
      alert("Invalid action.")
      this.router.navigate(['list-user']);
      return;
    }
    this.editForm = this.formBuilder.group({
      task_id: [],
	  parent_id:[],
      task: [''],
      priority: [''],
	  parent_task: [''],
      start_date: [''],
	  end_date: [''],
	  finished:[]
    });
    this.userService.getUserById(+userId)	
      .subscribe( data => {
        this.editForm.setValue(data);
      });
  }

  onSubmit() {
  
    this.userService.updateUser(this.editForm.value)
      .pipe(first())
      .subscribe(
        data => {
		
          this.router.navigate(['list-user']);
        },
        error => {
          alert(error);
        });
  }

}
