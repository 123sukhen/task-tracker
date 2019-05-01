import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {UserService} from "../service/user.service";
import {first} from "rxjs/operators";
import {Router} from "@angular/router";
import { Options } from 'ng5-slider';


@Component({
  selector: 'app-add-user',
  templateUrl: './add-task.component.html',
  styleUrls: ['./add-task.component.css']
})
export class AddUserComponent implements OnInit {

private value: number = 1;
  options: Options = {
    floor: 0,
    ceil: 30
  };
  
    public minDate: Date = new Date ("05/07/2017");
    public maxDate: Date = new Date ("05/27/2030");
    private k: Date = new Date ("05/16/2017");
  
  constructor(private formBuilder: FormBuilder,private router: Router, private userService: UserService) { }
  addForm: FormGroup;

  ngOnInit() {

    this.addForm = this.formBuilder.group({
      id:[],
      task: ['', Validators.required],
	  priority: ['', Validators.required],
      parent_task: ['', Validators.required],
	  start_date: ['', Validators.required],
	  end_date: ['', Validators.required]
    });

  }
  
  resetTask() {
    this.addForm.reset();
  }

  onSubmit() {
    this.userService.createUser(this.addForm.value)
      .subscribe( data => {
        this.router.navigate(['list-user']);
      });
  }
}
