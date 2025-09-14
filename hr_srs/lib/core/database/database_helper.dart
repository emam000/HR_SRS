import 'dart:developer';

import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/attendance/model/attendance_model.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/model/groups_model.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/model/permission_model.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/features/hr/payroll/model/payroll_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initializeDatabase();
      return _database!;
    }
  }

  Future initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, "hr.db");
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        Batch batch = db.batch();
        //! groups table ...

        batch.execute('''
            CREATE TABLE groups (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
            )
             ''');
        //! permissions table ...

        batch.execute('''
           CREATE TABLE permissions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
           name TEXT NOT NULL UNIQUE
             )
             ''');
        //! group_permissions table ...

        batch.execute('''
                CREATE TABLE group_permissions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
               group_id INTEGER NOT NULL,
              permission_id INTEGER NOT NULL,
             FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE,
            FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
             )
           ''');
        //! users table ...

        batch.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            full_name TEXT NOT NULL,
            role TEXT NOT NULL,
            username TEXT,
            email TEXT,
            password TEXT NOT NULL,
            created_at TEXT NOT NULL,
            group_id INTEGER,
           FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE SET NULL
          )
        ''');
        //! employees table ...

        batch.execute('''
          CREATE TABLE employees (
            id INTEGER PRIMARY KEY,
            full_name TEXT NOT NULL,
            national_id TEXT NOT NULL,
            birth_date TEXT NOT NULL,
            gender TEXT NOT NULL,
            nationality TEXT NOT NULL,
            phone TEXT NOT NULL,
            address TEXT NOT NULL,
            join_date TEXT NOT NULL,
            department TEXT NOT NULL,
            base_salary REAL NOT NULL,
            work_start TEXT NOT NULL,
            work_end TEXT NOT NULL,
            FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');
        //! attendance table ...

        batch.execute('''
          CREATE TABLE attendance (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            employee_id INTEGER NOT NULL,
            date TEXT NOT NULL,
            check_in TEXT NOT NULL,
            check_out TEXT NOT NULL,
            FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
          )
        ''');
        //! payroll table ...

        batch.execute('''
          CREATE TABLE payroll (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            employee_id INTEGER NOT NULL,
            month TEXT NOT NULL,
            base_salary REAL NOT NULL,
            deductions REAL NOT NULL,
            bonuses REAL NOT NULL,
            net_salary REAL NOT NULL,
            FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
          )
        ''');
        batch.execute(
            "INSERT INTO groups (id, name) VALUES (1, 'HR'), (2, 'Employee'), (3, 'Admin')");

        batch.execute('''
    INSERT INTO permissions (id, name) VALUES
    (1, 'manage_users'),
    (2, 'manage_employees'),
    (3, 'manage_attendance'),
    (4, 'manage_payroll'),
    (5, 'view_self_data'),
    (6, 'view_self_attendance'),
    (7, 'view_self_payroll')
  ''');

        batch.execute('''
    INSERT INTO group_permissions (group_id, permission_id) VALUES
    (1,1),(1,2),(1,3),(1,4),  -- HR
    (2,5),(2,6),(2,7),        -- Employee
    (3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7) -- Admin
  ''');

        batch.execute('''
    INSERT INTO users (id, full_name, username, email, password, role, created_at, group_id) VALUES
    (1, 'Super HR', 'hradmin', 'hr@example.com', '123456', 'HR', '2025-09-06T00:00:00.000', 1),
    (2, 'Employee One', 'emp1', 'emp1@example.com', '123456', 'Employee', '2025-09-06T00:00:00.000', 2)
  ''');

        batch.execute('''
    INSERT INTO employees (id, full_name, national_id, gender, birth_date, nationality, phone, address, join_date, department, base_salary, work_start, work_end) VALUES
    (2, 'Employee One', '12345678901234', 'ذكر', '1995-05-20', 'مصري', '01012345678', 'القاهرة', '2025-09-01', 'المبيعات', 8000, '09:00', '17:00')
  ''');

        await batch.commit();
      },
    );
  }

//!======================groups ========================//
  Future<List<GroupModel>> getAllGroups() async {
    final db = await getDatabase();
    final result = await db.query("groups");
    return result.map((map) => GroupModel.fromMap(map)).toList();
  }

  Future<int> insertGroup(GroupModel group) async {
    final db = await getDatabase();
    return await db.insert("groups", group.toMap());
  }

  Future<int> deleteGroup(int id) async {
    final db = await getDatabase();
    return await db.delete("groups", where: "id = ?", whereArgs: [id]);
  }

  //! ========================= perm =====================//

  Future<List<PermissionModel>> getAllPermissions() async {
    final db = await getDatabase();
    final result = await db.query("permissions");
    return result.map((map) => PermissionModel.fromMap(map)).toList();
  }

  Future<int> insertPermission(PermissionModel permission) async {
    final db = await getDatabase();
    return await db.insert("permissions", permission.toMap());
  }

  Future<int> deletePermission(int id) async {
    final db = await getDatabase();
    return await db.delete("permissions", where: "id = ?", whereArgs: [id]);
  }

//!====================== groups perm ===================//
  Future<List<int>> getPermissionsForGroup(int groupId) async {
    final db = await getDatabase();
    final result = await db.query(
      "group_permissions",
      where: "group_id = ?",
      whereArgs: [groupId],
    );
    return result.map((map) => map['permission_id'] as int).toList();
  }

  Future<int> insertGroupPermission(int groupId, int permissionId) async {
    final db = await getDatabase();
    return await db.insert("group_permissions", {
      "group_id": groupId,
      "permission_id": permissionId,
    });
  }

  Future<int> deleteGroupPermission(int groupId, int permissionId) async {
    final db = await getDatabase();
    return await db.delete(
      'group_permissions',
      where: 'group_id = ? AND permission_id = ?',
      whereArgs: [groupId, permissionId],
    );
  }

  //!===============users===========================//

// ! insert new user ...

  Future<int> insertUser(UserModel user) async {
    Database? db = await getDatabase();

    return await db.insert('users', user.toMap());
  }
//! get all users ...

  Future<List<UserModel>> getAllUsers() async {
    Database? db = await getDatabase();
    List<Map<String, dynamic>> users = await db.query('users');
    return users.map((user) => UserModel.fromMap(user)).toList();
  }
//! get user by username  ...

  Future<UserModel?> getUserById(int id) async {
    Database? db = await getDatabase();
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }
//! update user ...

  Future<int> updateUser(UserModel user) async {
    Database? db = await getDatabase();
    return await db.update(
      'users',
      user.toMap(),
      whereArgs: [user.id],
      where: 'id = ?',
    );
  }
//! delete user by id ...

  Future<int> deleteUserById(int id) async {
    Database? db = await getDatabase();
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
//! delete All user data (All user Tabel ) ...

  Future<void> deleteAllUserData() async {
    Database? db = await getDatabase();
    await db.delete("users");
  }
//!====================employee===================//

  Future<int> insertEmployee(EmployeeModel employee) async {
    Database? db = await getDatabase();

    return await db.insert('employees', employee.toMap());
  }

  Future<List<EmployeeModel>> getAllEmployees() async {
    Database? db = await getDatabase();

    final List<Map<String, dynamic>> employees = await db.query('employees');
    return employees
        .map((employee) => EmployeeModel.fromMap(employee))
        .toList();
  }

  Future<EmployeeModel?> getEmployeeById(int id) async {
    Database? db = await getDatabase();

    final maps = await db.query(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return EmployeeModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateEmployee(EmployeeModel employee) async {
    Database? db = await getDatabase();

    return await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    Database? db = await getDatabase();

    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //! delete all emplyee data (all table) ....
  Future<void> deleteAllEmplyeeData() async {
    Database? db = await getDatabase();
    await db.delete("employees");
  }

//!==============================attendance =============//

  Future<int> insertAttendance(AttendanceModel attendance) async {
    Database? db = await getDatabase();

    return await db.insert('attendance', attendance.toMap());
  }

  Future<List<AttendanceModel>> getAllAttendance() async {
    Database? db = await getDatabase();

    final List<Map<String, dynamic>> attendance = await db.query('attendance');
    return attendance
        .map((attendance) => AttendanceModel.fromMap(attendance))
        .toList();
  }

  Future<List<AttendanceModel>> getAttendanceByEmployeeId(
      int employeeId) async {
    final db = await getDatabase();
    final result = await db.query(
      'attendance',
      where: 'employee_id = ?',
      whereArgs: [employeeId],
    );
    return result.map((e) => AttendanceModel.fromMap(e)).toList();
  }

  Future<List<AttendanceModel>> getAttendanceByDateRange(
      String startDate, String endDate) async {
    Database? db = await getDatabase();

    final attendance = await db.query(
      'attendance',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
    );
    return attendance
        .map((attendance) => AttendanceModel.fromMap(attendance))
        .toList();
  }

  Future<int> updateAttendance(AttendanceModel attendance) async {
    Database? db = await getDatabase();

    return await db.update(
      'attendance',
      attendance.toMap(),
      where: 'id = ?',
      whereArgs: [attendance.id],
    );
  }

  Future<int> deleteAttendance(int id) async {
    Database? db = await getDatabase();

    return await db.delete(
      'attendance',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //! delete all attendance data (all table) ....
  Future<void> deleteAllAttendanceData() async {
    Database? db = await getDatabase();
    await db.delete("attendance");
  }

  //!===============payroll===========================//

  Future<int> insertPayroll(PayrollModel payroll) async {
    Database? db = await getDatabase();

    return await db.insert('payroll', payroll.toMap());
  }

  Future<List<PayrollModel>> getAllPayrolls() async {
    Database? db = await getDatabase();

    final List<Map<String, dynamic>> payroll = await db.query('payroll');
    return payroll.map((payroll) => PayrollModel.fromMap(payroll)).toList();
  }

  Future<List<PayrollModel>> getPayrollsByEmployee(int employeeId) async {
    Database? db = await getDatabase();

    final payroll = await db.query(
      'payroll',
      where: 'employee_id = ?',
      whereArgs: [employeeId],
    );
    return payroll.map((payroll) => PayrollModel.fromMap(payroll)).toList();
  }

  Future<List<PayrollModel>> getPayrollsByMonth(String month) async {
    Database? db = await getDatabase();

    final payroll = await db.query(
      'payroll',
      where: 'month = ?',
      whereArgs: [month],
    );
    return payroll.map((payroll) => PayrollModel.fromMap(payroll)).toList();
  }

  Future<int> updatePayroll(PayrollModel payroll) async {
    Database? db = await getDatabase();

    return await db.update(
      'payroll',
      payroll.toMap(),
      where: 'id = ?',
      whereArgs: [payroll.id],
    );
  }

  Future<int> deletePayroll(int id) async {
    Database? db = await getDatabase();

    return await db.delete(
      'payroll',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //! delete all attendance data (all table) ....
  Future<void> deleteAllPayrollData() async {
    Database? db = await getDatabase();
    await db.delete("payroll");
  }

  //!=================================== auth user ================//

  Future<Map<String, dynamic>?> authenticateUser({
    required String identifier,
    required String password,
  }) async {
    Database db = await getDatabase();

    String? where;
    List<dynamic>? whereArgs;

    if (identifier.contains('@')) {
      where = 'email = ? AND password = ?';
      whereArgs = [identifier, password];
    } else {
      where = 'username = ? AND password = ?';
      whereArgs = [identifier, password];
    }

    final result = await db.query(
      'users',
      where: where,
      whereArgs: whereArgs,
    );

    if (result.isNotEmpty) {
      final user = UserModel.fromMap(result.first);

      if (user.role == 'Employee') {
        final empResult = await db.query(
          'employees',
          where: 'id = ?',
          whereArgs: [user.id],
        );

        if (empResult.isNotEmpty) {
          final employee = EmployeeModel.fromMap(empResult.first);

          return {
            'user': user,
            'employee': employee,
          };
        }
      }

      return {
        'user': user,
      };
    }

    return null;
  }
}

Future<void> delete() async {
  await DatabaseHelper().deleteAllUserData();
  await DatabaseHelper().deleteAllEmplyeeData();
  await DatabaseHelper().deleteAllAttendanceData();
  await DatabaseHelper().deleteAllPayrollData();
  log("allldeleted ");
}
