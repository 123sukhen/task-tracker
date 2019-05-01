import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import {routing} from "./app.routing";
import {AuthenticationService} from "./service/auth.service";
import {ReactiveFormsModule} from "@angular/forms";
import {HttpClientModule} from "@angular/common/http";
import { AddUserComponent } from './add-task/add-task.component';
import { EditUserComponent } from './edit-task/edit-task.component';
import {ListUserComponent} from "./list-task/list-task.component";
import {UserService} from "./service/user.service";
import { Ng5SliderModule } from 'ng5-slider';
import { DatePickerModule } from '@syncfusion/ej2-angular-calendars';
import { Ng2FilterPipeModule } from 'ng2-filter-pipe';
import { FormsModule } from '@angular/forms';
import { FilterPipeModule } from 'ngx-filter-pipe';
import { Pipe, PipeTransform } from '@angular/core'; 
import {CommonModule} from "@angular/common";




@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    ListUserComponent,
    AddUserComponent,
    EditUserComponent
	
  ],
  imports: [
    BrowserModule,
    routing,
    ReactiveFormsModule,
    HttpClientModule,
	Ng5SliderModule,
	DatePickerModule,
	Ng2FilterPipeModule,
	FilterPipeModule,
	FormsModule,
	 
  ],
  providers: [AuthenticationService, UserService],
  bootstrap: [AppComponent]
})
export class AppModule { }
