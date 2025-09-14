// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in`
  String get signin {
    return Intl.message('Sign in', name: 'signin', desc: '', args: []);
  }

  /// `Email Or Username`
  String get hintEmailOrUsername {
    return Intl.message(
      'Email Or Username',
      name: 'hintEmailOrUsername',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get hintPassword {
    return Intl.message('Password', name: 'hintPassword', desc: '', args: []);
  }

  /// `Users Dep`
  String get users {
    return Intl.message('Users Dep', name: 'users', desc: '', args: []);
  }

  /// `Employees Dep`
  String get employee {
    return Intl.message('Employees Dep', name: 'employee', desc: '', args: []);
  }

  /// `Groups And Permission Dep`
  String get groupsAndPerm {
    return Intl.message(
      'Groups And Permission Dep',
      name: 'groupsAndPerm',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Dep`
  String get attendance {
    return Intl.message(
      'Attendance Dep',
      name: 'attendance',
      desc: '',
      args: [],
    );
  }

  /// `Payroll Dep`
  String get payroll {
    return Intl.message('Payroll Dep', name: 'payroll', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `HR System`
  String get homeTitle {
    return Intl.message('HR System', name: 'homeTitle', desc: '', args: []);
  }

  /// `Enter A Valid Email`
  String get validEmail {
    return Intl.message(
      'Enter A Valid Email',
      name: 'validEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter A Valid Password`
  String get validPassword {
    return Intl.message(
      'Enter A Valid Password',
      name: 'validPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to access your account`
  String get slogan {
    return Intl.message(
      'Sign in to access your account',
      name: 'slogan',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back !`
  String get welcome {
    return Intl.message('Welcome Back !', name: 'welcome', desc: '', args: []);
  }

  /// `Sign in Successfully to HR`
  String get signInSuccesHR {
    return Intl.message(
      'Sign in Successfully to HR',
      name: 'signInSuccesHR',
      desc: '',
      args: [],
    );
  }

  /// `Sign in Successfully to Employee`
  String get signInSuccesEmp {
    return Intl.message(
      'Sign in Successfully to Employee',
      name: 'signInSuccesEmp',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email Or Username And Password`
  String get emptyEmailAndPass {
    return Intl.message(
      'Please Enter Your Email Or Username And Password',
      name: 'emptyEmailAndPass',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email Or Username`
  String get emptyEmail {
    return Intl.message(
      'Please Enter Your Email Or Username',
      name: 'emptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Password`
  String get EmptyPassword {
    return Intl.message(
      'Please Enter Your Password',
      name: 'EmptyPassword',
      desc: '',
      args: [],
    );
  }

  /// `There are no Users till now`
  String get emptyUsers {
    return Intl.message(
      'There are no Users till now',
      name: 'emptyUsers',
      desc: '',
      args: [],
    );
  }

  /// `User Deleted Successfully`
  String get deleteUser {
    return Intl.message(
      'User Deleted Successfully',
      name: 'deleteUser',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Role`
  String get role {
    return Intl.message('Role', name: 'role', desc: '', args: []);
  }

  /// `Edit User Data`
  String get editUserData {
    return Intl.message(
      'Edit User Data',
      name: 'editUserData',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveEdits {
    return Intl.message('Save Changes', name: 'saveEdits', desc: '', args: []);
  }

  /// `This Field is Required`
  String get requiredField {
    return Intl.message(
      'This Field is Required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Email Is Required For Employee Account`
  String get emailRequForEmpAcc {
    return Intl.message(
      'Email Is Required For Employee Account',
      name: 'emailRequForEmpAcc',
      desc: '',
      args: [],
    );
  }

  /// `Username Is Required For HR Account`
  String get userRequForHRAcc {
    return Intl.message(
      'Username Is Required For HR Account',
      name: 'userRequForHRAcc',
      desc: '',
      args: [],
    );
  }

  /// `There are no Employee till now`
  String get emptyEmployee {
    return Intl.message(
      'There are no Employee till now',
      name: 'emptyEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Press On + Button To Add First Employee`
  String get toAddEmployee {
    return Intl.message(
      'Press On + Button To Add First Employee',
      name: 'toAddEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Employee Deleted Successfully`
  String get deleteEmployee {
    return Intl.message(
      'Employee Deleted Successfully',
      name: 'deleteEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Edit Employee Data`
  String get editEmployeeData {
    return Intl.message(
      'Edit Employee Data',
      name: 'editEmployeeData',
      desc: '',
      args: [],
    );
  }

  /// `National ID`
  String get nationalID {
    return Intl.message('National ID', name: 'nationalID', desc: '', args: []);
  }

  /// `phone Number`
  String get phoneNumber {
    return Intl.message(
      'phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message('Department', name: 'department', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Nationality`
  String get nationality {
    return Intl.message('Nationality', name: 'nationality', desc: '', args: []);
  }

  /// `Salary`
  String get salary {
    return Intl.message('Salary', name: 'salary', desc: '', args: []);
  }

  /// `Work Start`
  String get workStart {
    return Intl.message('Work Start', name: 'workStart', desc: '', args: []);
  }

  /// `Work End`
  String get workEnd {
    return Intl.message('Work End', name: 'workEnd', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Date Of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date Of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Join Date`
  String get joinDate {
    return Intl.message('Join Date', name: 'joinDate', desc: '', args: []);
  }

  /// `Work Time Start At 09:00 AM`
  String get workTimeStartAt {
    return Intl.message(
      'Work Time Start At 09:00 AM',
      name: 'workTimeStartAt',
      desc: '',
      args: [],
    );
  }

  /// `Work Time End At 05:00 PM`
  String get workTimeEndAt {
    return Intl.message(
      'Work Time End At 05:00 PM',
      name: 'workTimeEndAt',
      desc: '',
      args: [],
    );
  }

  /// `Choose Birthday`
  String get chooseBirthday {
    return Intl.message(
      'Choose Birthday',
      name: 'chooseBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Choose join Date`
  String get chooseJoinDate {
    return Intl.message(
      'Choose join Date',
      name: 'chooseJoinDate',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `HR`
  String get hr {
    return Intl.message('HR', name: 'hr', desc: '', args: []);
  }

  /// `Employee`
  String get emp {
    return Intl.message('Employee', name: 'emp', desc: '', args: []);
  }

  /// `Changes Saved Saccessfully`
  String get saveChangesSucces {
    return Intl.message(
      'Changes Saved Saccessfully',
      name: 'saveChangesSucces',
      desc: '',
      args: [],
    );
  }

  /// `Employee Added Successfully`
  String get addEmployeesuccess {
    return Intl.message(
      'Employee Added Successfully',
      name: 'addEmployeesuccess',
      desc: '',
      args: [],
    );
  }

  /// `Add Employee`
  String get addEmployee {
    return Intl.message(
      'Add Employee',
      name: 'addEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Login Data`
  String get loginData {
    return Intl.message('Login Data', name: 'loginData', desc: '', args: []);
  }

  /// `Employee Data`
  String get employeeData {
    return Intl.message(
      'Employee Data',
      name: 'employeeData',
      desc: '',
      args: [],
    );
  }

  /// `No Groups Till Now`
  String get noGroups {
    return Intl.message(
      'No Groups Till Now',
      name: 'noGroups',
      desc: '',
      args: [],
    );
  }

  /// `Permissions`
  String get permissions {
    return Intl.message('Permissions', name: 'permissions', desc: '', args: []);
  }

  /// `Loading ...`
  String get loading {
    return Intl.message('Loading ...', name: 'loading', desc: '', args: []);
  }

  /// `Add New Group`
  String get addNewGroup {
    return Intl.message(
      'Add New Group',
      name: 'addNewGroup',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get groupName {
    return Intl.message('Group Name', name: 'groupName', desc: '', args: []);
  }

  /// `cancel`
  String get cancel {
    return Intl.message('cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Please Enter The Group Name`
  String get pleaseEnterGroupName {
    return Intl.message(
      'Please Enter The Group Name',
      name: 'pleaseEnterGroupName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Did you want To Delete`
  String get didYouWantDelete {
    return Intl.message(
      'Did you want To Delete',
      name: 'didYouWantDelete',
      desc: '',
      args: [],
    );
  }

  /// `Attendance For All Employees`
  String get attndenceTitle {
    return Intl.message(
      'Attendance For All Employees',
      name: 'attndenceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Logoin`
  String get login {
    return Intl.message('Logoin', name: 'login', desc: '', args: []);
  }

  /// `No Attendance Yet`
  String get noAttendance {
    return Intl.message(
      'No Attendance Yet',
      name: 'noAttendance',
      desc: '',
      args: [],
    );
  }

  /// `Checkin`
  String get checkin {
    return Intl.message('Checkin', name: 'checkin', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `No Payroll Data Yet`
  String get noPayoll {
    return Intl.message(
      'No Payroll Data Yet',
      name: 'noPayoll',
      desc: '',
      args: [],
    );
  }

  /// `Base Salary`
  String get baseSalary {
    return Intl.message('Base Salary', name: 'baseSalary', desc: '', args: []);
  }

  /// `There is no data. Press + to add bonuses or deductions`
  String get toAddPayroll {
    return Intl.message(
      'There is no data. Press + to add bonuses or deductions',
      name: 'toAddPayroll',
      desc: '',
      args: [],
    );
  }

  /// `net Salary`
  String get netSalary {
    return Intl.message('net Salary', name: 'netSalary', desc: '', args: []);
  }

  /// `Salary Deleted Successfully`
  String get deleteMessgPayroll {
    return Intl.message(
      'Salary Deleted Successfully',
      name: 'deleteMessgPayroll',
      desc: '',
      args: [],
    );
  }

  /// `Add Bonuses And Deductions`
  String get addBonusesOrDeductions {
    return Intl.message(
      'Add Bonuses And Deductions',
      name: 'addBonusesOrDeductions',
      desc: '',
      args: [],
    );
  }

  /// `Month (MM-YYYY)`
  String get month {
    return Intl.message('Month (MM-YYYY)', name: 'month', desc: '', args: []);
  }

  /// `Bonuses`
  String get bonuses {
    return Intl.message('Bonuses', name: 'bonuses', desc: '', args: []);
  }

  /// `Deductions`
  String get deductions {
    return Intl.message('Deductions', name: 'deductions', desc: '', args: []);
  }

  /// `Payroll Added Successfully`
  String get addpayrollMessg {
    return Intl.message(
      'Payroll Added Successfully',
      name: 'addpayrollMessg',
      desc: '',
      args: [],
    );
  }

  /// `My Data`
  String get myData {
    return Intl.message('My Data', name: 'myData', desc: '', args: []);
  }

  /// `Checkin Successfully`
  String get checkinMessage {
    return Intl.message(
      'Checkin Successfully',
      name: 'checkinMessage',
      desc: '',
      args: [],
    );
  }

  /// `Checkout Successfully`
  String get CheckoutMessage {
    return Intl.message(
      'Checkout Successfully',
      name: 'CheckoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `unavilable`
  String get unavilable {
    return Intl.message('unavilable', name: 'unavilable', desc: '', args: []);
  }

  /// `You Are Already Checkin Today`
  String get alredayChekin {
    return Intl.message(
      'You Are Already Checkin Today',
      name: 'alredayChekin',
      desc: '',
      args: [],
    );
  }

  /// `You Are Already Checkout Today`
  String get alredayChekout {
    return Intl.message(
      'You Are Already Checkout Today',
      name: 'alredayChekout',
      desc: '',
      args: [],
    );
  }

  /// `There Is No Checkin Today`
  String get NoCheckintoday {
    return Intl.message(
      'There Is No Checkin Today',
      name: 'NoCheckintoday',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
