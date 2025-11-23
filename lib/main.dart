import 'package:flutter/material.dart';

void main() {
  runApp(const BmcWebApp());
}

class BmcWebApp extends StatelessWidget {
  const BmcWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
          centerTitle: true,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class Patient {
  String name;
  int age;
  String gender;
  String status;
  String notes;

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    required this.status,
    required this.notes,
  });
}

class Doctor {
  String name;
  String specialty;
  String room;
  String phone;
  String notes;

  Doctor({
    required this.name,
    required this.specialty,
    required this.room,
    required this.phone,
    required this.notes,
  });
}

class Appointment {
  String patientName;
  String doctorName;
  String date;
  String time;
  String status;

  Appointment({
    required this.patientName,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.status,
  });
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  bool isArabic = true;
  int _selectedIndex = 0;

  final List<Patient> _patients = [
    Patient(
      name: 'Mohammad Saleh',
      age: 45,
      gender: 'Male',
      status: 'Follow-up',
      notes: 'Diabetes – monthly check.',
    ),
    Patient(
      name: 'Aya Hassan',
      age: 32,
      gender: 'Female',
      status: 'Today appointment',
      notes: 'Chest pain investigation.',
    ),
    Patient(
      name: 'Khaled Omar',
      age: 51,
      gender: 'Male',
      status: 'Lab result review',
      notes: 'Hypertension and high cholesterol.',
    ),
  ];

  final List<Doctor> _doctors = [
    Doctor(
      name: 'Dr. Hamza Al-Radaideh',
      specialty: 'Internal Medicine',
      room: 'Room 101',
      phone: '+970-59-0000001',
      notes: 'Medical centre director.',
    ),
    Doctor(
      name: 'Dr. Ghada Al-Rabaye’ah',
      specialty: 'Emergency Medicine',
      room: 'ER 02',
      phone: '+970-59-0000002',
      notes: 'Emergency department.',
    ),
  ];

  final List<Appointment> _appointments = [
    Appointment(
      patientName: 'Mohammad Saleh',
      doctorName: 'Dr. Hamza Al-Radaideh',
      date: '2025-11-25',
      time: '10:30',
      status: 'Confirmed',
    ),
    Appointment(
      patientName: 'Aya Hassan',
      doctorName: 'Dr. Ghada Al-Rabaye’ah',
      date: '2025-11-25',
      time: '12:00',
      status: 'Pending',
    ),
  ];

  void _toggleLanguage() {
    setState(() {
      isArabic = !isArabic;
    });
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addPatient(Patient p) {
    setState(() {
      _patients.add(p);
    });
  }

  void _updatePatient(int index, Patient p) {
    setState(() {
      _patients[index] = p;
    });
  }

  void _deletePatient(int index) {
    setState(() {
      _patients.removeAt(index);
    });
  }

  void _addDoctor(Doctor d) {
    setState(() {
      _doctors.add(d);
    });
  }

  void _updateDoctor(int index, Doctor d) {
    setState(() {
      _doctors[index] = d;
    });
  }

  void _deleteDoctor(int index) {
    setState(() {
      _doctors.removeAt(index);
    });
  }

  void _addAppointment(Appointment a) {
    setState(() {
      _appointments.add(a);
    });
  }

  void _updateAppointment(int index, Appointment a) {
    setState(() {
      _appointments[index] = a;
    });
  }

  void _deleteAppointment(int index) {
    setState(() {
      _appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppText(isArabic);

    Widget body;
    if (_selectedIndex == 0) {
      body = HomePage(isArabic: isArabic);
    } else if (_selectedIndex == 1) {
      body = PatientsDashboard(
        isArabic: isArabic,
        patients: _patients,
        onAdd: _addPatient,
        onUpdate: _updatePatient,
        onDelete: _deletePatient,
      );
    } else if (_selectedIndex == 2) {
      body = DoctorsDashboard(
        isArabic: isArabic,
        doctors: _doctors,
        onAdd: _addDoctor,
        onUpdate: _updateDoctor,
        onDelete: _deleteDoctor,
      );
    } else if (_selectedIndex == 3) {
      body = AppointmentsDashboard(
        isArabic: isArabic,
        appointments: _appointments,
        patients: _patients,
        doctors: _doctors,
        onAdd: _addAppointment,
        onUpdate: _updateAppointment,
        onDelete: _deleteAppointment,
      );
    } else {
      body = LoginPage(isArabic: isArabic);
    }

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 180,
          leading: Row(
            children: const [
              SizedBox(width: 12),
              Icon(Icons.local_hospital, color: Colors.indigo),
            ],
          ),
          title: Text(
            'BMC Medical Centre',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            TextButton.icon(
              onPressed: _toggleLanguage,
              icon: const Icon(Icons.language, size: 18),
              label: Text(t.languageLabel),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onNavTap,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: t.navHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people_alt_outlined),
              label: t.navPatients,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.medical_information_outlined),
              label: t.navDoctors,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.event_note_outlined),
              label: t.navAppointments,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.login),
              label: t.navLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class AppText {
  final bool ar;
  const AppText(this.ar);

  bool get isArabic => ar;

  String get languageLabel => ar ? 'العربية / English' : 'English / العربية';

  String get navHome => ar ? 'الرئيسية' : 'Home';
  String get navPatients => ar ? 'المرضى' : 'Patients';
  String get navDoctors => ar ? 'الأطباء' : 'Doctors';
  String get navAppointments => ar ? 'المواعيد' : 'Appointments';
  String get navLogin => ar ? 'تسجيل الدخول' : 'Login';

  String get homeTitle =>
      ar ? 'تطبيق مركز BMC الطبي' : 'BMC Medical Centre Application';
  String get homeSubtitle => ar
      ? 'نظام ويب متكامل لإدارة المرضى، الأطباء، والمواعيد في مركز BMC الطبي، بواجهة بسيطة ومنظّمة تدعم العربية والإنجليزية.'
      : 'A complete web system to manage patients, doctors and appointments in the BMC Medical Centre, with a clean bilingual interface.';
  String get homeBullet1 => ar
      ? 'إدارة المرضى: عرض، إضافة، تعديل، وحذف.'
      : 'Patients management: view, add, edit and delete.';
  String get homeBullet2 => ar
      ? 'إدارة الأطباء والتخصّصات وغرف العيادات ووسائل التواصل.'
      : 'Doctors management with specialties, rooms and contact details.';
  String get homeBullet3 => ar
      ? 'تنظيم المواعيد بين الأطباء والمرضى مع حالة الموعد وتوقيته.'
      : 'Appointments scheduling between doctors and patients with date, time and status.';
  String get homeHint => ar
      ? 'استخدم شريط التنقّل في الأسفل للانتقال بين المرضى، الأطباء، المواعيد، وتسجيل الدخول.'
      : 'Use the bottom navigation bar to move between Patients, Doctors, Appointments and Login.';

  String get patientsTitle =>
      ar ? 'إدارة المرضى في مركز BMC' : 'Patients Management in BMC Centre';
  String get patientsSubtitle => ar
      ? 'هذه الشاشة تتيح للطبيب أو الموظف عرض قائمة المرضى، إضافة مريض جديد، تعديل البيانات الحالية أو حذف مريض.'
      : 'This screen allows the doctor or staff to view patients, add new records, edit existing data, or remove a patient.';

  String get statsPatients => ar ? 'عدد المرضى' : 'Total patients';
  String get statsMale => ar ? 'ذكور' : 'Male patients';
  String get statsFemale => ar ? 'إناث' : 'Female patients';

  String get colName => ar ? 'الاسم' : 'Name';
  String get colAge => ar ? 'العمر' : 'Age';
  String get colGender => ar ? 'الجنس' : 'Gender';
  String get colStatus => ar ? 'الحالة' : 'Status';
  String get colNotes => ar ? 'ملاحظات' : 'Notes';
  String get colActions => ar ? 'خيارات' : 'Actions';

  String get btnAddPatient => ar ? 'إضافة مريض' : 'Add patient';

  String get formTitleAddPatient => ar ? 'إضافة مريض جديد' : 'Add new patient';
  String get formTitleEditPatient =>
      ar ? 'تعديل بيانات المريض' : 'Edit patient';

  String get labelNamePatient => ar ? 'اسم المريض' : 'Patient name';
  String get labelAgePatient => ar ? 'العمر' : 'Age';
  String get labelGenderPatient => ar ? 'الجنس' : 'Gender';
  String get labelStatusPatient => ar ? 'الحالة' : 'Status';
  String get labelNotesPatient => ar ? 'ملاحظات طبية' : 'Medical notes';

  String get genderMale => ar ? 'ذكر' : 'Male';
  String get genderFemale => ar ? 'أنثى' : 'Female';

  String get doctorsTitle =>
      ar ? 'إدارة الأطباء في مركز BMC' : 'Doctors Management in BMC Centre';
  String get doctorsSubtitle => ar
      ? 'يمكن من هنا إدارة بيانات الأطباء، تخصّصاتهم، غرفهم، وأرقام التواصل.'
      : 'From here we manage doctors data, specialties, rooms and contact numbers.';

  String get btnAddDoctor => ar ? 'إضافة طبيب' : 'Add doctor';

  String get colDoctorName => ar ? 'اسم الطبيب' : 'Doctor name';
  String get colSpecialty => ar ? 'التخصّص' : 'Specialty';
  String get colRoom => ar ? 'الغرفة / العيادة' : 'Room / Clinic';
  String get colPhone => ar ? 'رقم الهاتف' : 'Phone';

  String get formTitleAddDoctor => ar ? 'إضافة طبيب جديد' : 'Add new doctor';
  String get formTitleEditDoctor => ar ? 'تعديل بيانات الطبيب' : 'Edit doctor';

  String get labelDoctorName => ar ? 'اسم الطبيب' : 'Doctor name';
  String get labelSpecialty => ar ? 'التخصّص' : 'Specialty';
  String get labelRoom => ar ? 'الغرفة / العيادة' : 'Room / Clinic';
  String get labelPhone => ar ? 'رقم الهاتف' : 'Phone number';
  String get labelDoctorNotes => ar ? 'ملاحظات إضافية' : 'Additional notes';

  String get appointmentsTitle => ar
      ? 'إدارة المواعيد في مركز BMC'
      : 'Appointments Management in BMC Centre';
  String get appointmentsSubtitle => ar
      ? 'تنظيم المواعيد بين الأطباء والمرضى مع تاريخ ووقت وحالة كل موعد.'
      : 'Organize appointments between doctors and patients with date, time and status.';

  String get btnAddAppointment => ar ? 'إضافة موعد' : 'Add appointment';

  String get colApptPatient => ar ? 'المريض' : 'Patient';
  String get colApptDoctor => ar ? 'الطبيب' : 'Doctor';
  String get colApptDate => ar ? 'التاريخ' : 'Date';
  String get colApptTime => ar ? 'الوقت' : 'Time';
  String get colApptStatus => ar ? 'حالة الموعد' : 'Status';

  String get formTitleAddAppointment =>
      ar ? 'إضافة موعد جديد' : 'Add new appointment';
  String get formTitleEditAppointment =>
      ar ? 'تعديل بيانات الموعد' : 'Edit appointment';

  String get labelApptPatient => ar ? 'اسم المريض' : 'Patient name';
  String get labelApptDoctor => ar ? 'اسم الطبيب' : 'Doctor name';
  String get labelApptDate =>
      ar ? 'تاريخ الموعد (YYYY-MM-DD)' : 'Date (YYYY-MM-DD)';
  String get labelApptTime => ar ? 'وقت الموعد (HH:MM)' : 'Time (HH:MM)';
  String get labelApptStatus => ar ? 'حالة الموعد' : 'Appointment status';

  String get save => ar ? 'حفظ' : 'Save';
  String get cancel => ar ? 'إلغاء' : 'Cancel';
  String get delete => ar ? 'حذف' : 'Delete';

  String get errorRequired => ar ? 'هذا الحقل مطلوب' : 'This field is required';
  String get errorAge => ar ? 'أدخل عمر صحيح' : 'Enter a valid age';

  String get loginTitle => ar ? 'تسجيل الدخول للنظام' : 'Login to the system';
  String get loginSubtitle => ar
      ? 'هذه الشاشة مخصّصة لدخول الأطباء أو الموظفين إلى نظام مركز BMC الطبي.'
      : 'This screen is for doctors or staff to sign in to the BMC medical centre system.';
  String get emailLabel => ar ? 'البريد الإلكتروني' : 'E-mail';
  String get passwordLabel => ar ? 'كلمة المرور' : 'Password';
  String get rememberMe => ar ? 'تذكّرني' : 'Remember me';
  String get loginButton => ar ? 'دخول' : 'Sign in';
  String get loginInfo => ar
      ? 'عند تسجيل الدخول يمكن للطبيب أو الموظف الوصول إلى واجهة النظام وإدارة البيانات.'
      : 'After signing in, doctors and staff can access the system interface and manage the data.';
}

class HomePage extends StatelessWidget {
  final bool isArabic;
  const HomePage({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final t = AppText(isArabic);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 30.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    t.homeTitle,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    t.homeSubtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 26),
                  _bullet(t.homeBullet1, isArabic),
                  const SizedBox(height: 6),
                  _bullet(t.homeBullet2, isArabic),
                  const SizedBox(height: 6),
                  _bullet(t.homeBullet3, isArabic),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: isArabic
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Colors.indigo.shade600,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            t.homeHint,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.indigo.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bullet(String text, bool ar) {
    return Row(
      mainAxisAlignment: ar ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!ar) const Icon(Icons.check_circle, size: 16, color: Colors.indigo),
        if (!ar) const SizedBox(width: 8),
        Expanded(
          child: Text(text, textAlign: ar ? TextAlign.right : TextAlign.left),
        ),
        if (ar) const SizedBox(width: 8),
        if (ar) const Icon(Icons.check_circle, size: 16, color: Colors.indigo),
      ],
    );
  }
}

class PatientsDashboard extends StatelessWidget {
  final bool isArabic;
  final List<Patient> patients;
  final void Function(Patient) onAdd;
  final void Function(int, Patient) onUpdate;
  final void Function(int) onDelete;

  const PatientsDashboard({
    super.key,
    required this.isArabic,
    required this.patients,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppText(isArabic);

    final total = patients.length;
    final males = patients
        .where((p) => p.gender.toLowerCase().startsWith('m'))
        .length;
    final females = patients
        .where((p) => p.gender.toLowerCase().startsWith('f'))
        .length;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: isArabic
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                t.patientsTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                t.patientsSubtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _statCard(
                    title: t.statsPatients,
                    value: '$total',
                    icon: Icons.people_alt_outlined,
                    color: Colors.indigo,
                  ),
                  const SizedBox(width: 12),
                  _statCard(
                    title: t.statsMale,
                    value: '$males',
                    icon: Icons.male,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _statCard(
                    title: t.statsFemale,
                    value: '$females',
                    icon: Icons.female,
                    color: Colors.pink,
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () => _openPatientForm(context, isArabic, t),
                    icon: const Icon(Icons.person_add_alt_1),
                    label: Text(t.btnAddPatient),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: patients.isEmpty
                        ? Center(
                            child: Text(
                              isArabic
                                  ? 'لا يوجد مرضى حالياً. قم بإضافة مريض جديد.'
                                  : 'No patients yet. Please add a new patient.',
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text(t.colName)),
                                DataColumn(label: Text(t.colAge)),
                                DataColumn(label: Text(t.colGender)),
                                DataColumn(label: Text(t.colStatus)),
                                DataColumn(label: Text(t.colNotes)),
                                DataColumn(label: Text(t.colActions)),
                              ],
                              rows: [
                                for (int i = 0; i < patients.length; i++)
                                  _buildRow(
                                    context: context,
                                    index: i,
                                    patient: patients[i],
                                    t: t,
                                  ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: 190,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildRow({
    required BuildContext context,
    required int index,
    required Patient patient,
    required AppText t,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(patient.name)),
        DataCell(Text(patient.age.toString())),
        DataCell(Text(patient.gender)),
        DataCell(Text(patient.status)),
        DataCell(
          SizedBox(
            width: 220,
            child: Text(
              patient.notes,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: t.save,
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () => _openPatientForm(
                  context,
                  t.isArabic,
                  t,
                  existing: patient,
                  index: index,
                ),
              ),
              IconButton(
                tooltip: t.delete,
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: () => _confirmDelete(context, index, t),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, int index, AppText t) {
    final isArabic = t.isArabic;
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(t.delete),
          content: Text(
            isArabic
                ? 'هل أنت متأكد من حذف هذا المريض؟'
                : 'Are you sure you want to delete this patient?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(t.cancel),
            ),
            TextButton(
              onPressed: () {
                onDelete(index);
                Navigator.pop(ctx);
              },
              child: Text(t.delete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void _openPatientForm(
    BuildContext context,
    bool isArabic,
    AppText t, {
    Patient? existing,
    int? index,
  }) {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final ageCtrl = TextEditingController(
      text: existing != null ? '${existing.age}' : '',
    );
    final statusCtrl = TextEditingController(text: existing?.status ?? '');
    final notesCtrl = TextEditingController(text: existing?.notes ?? '');
    String gender = existing?.gender.isNotEmpty == true
        ? existing!.gender
        : t.genderMale;

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              existing == null ? t.formTitleAddPatient : t.formTitleEditPatient,
            ),
            content: SizedBox(
              width: 420,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelNamePatient,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: ageCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelAgePatient,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return t.errorRequired;
                          }
                          final age = int.tryParse(v);
                          if (age == null || age <= 0) return t.errorAge;
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: gender,
                        items: [
                          DropdownMenuItem(
                            value: t.genderMale,
                            child: Text(t.genderMale),
                          ),
                          DropdownMenuItem(
                            value: t.genderFemale,
                            child: Text(t.genderFemale),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            gender = val;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: t.labelGenderPatient,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: statusCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelStatusPatient,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: notesCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelNotesPatient,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(t.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final p = Patient(
                    name: nameCtrl.text.trim(),
                    age: int.parse(ageCtrl.text.trim()),
                    gender: gender,
                    status: statusCtrl.text.trim(),
                    notes: notesCtrl.text.trim(),
                  );

                  if (existing == null) {
                    onAdd(p);
                  } else if (index != null) {
                    onUpdate(index, p);
                  }

                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: Text(t.save),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DoctorsDashboard extends StatelessWidget {
  final bool isArabic;
  final List<Doctor> doctors;
  final void Function(Doctor) onAdd;
  final void Function(int, Doctor) onUpdate;
  final void Function(int) onDelete;

  const DoctorsDashboard({
    super.key,
    required this.isArabic,
    required this.doctors,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppText(isArabic);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: isArabic
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                t.doctorsTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                t.doctorsSubtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    '${doctors.length}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isArabic ? 'طبيب/ة مسجّل في المركز' : 'doctors registered',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () => _openDoctorForm(context, isArabic, t),
                    icon: const Icon(Icons.person_add),
                    label: Text(t.btnAddDoctor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: doctors.isEmpty
                        ? Center(
                            child: Text(
                              isArabic
                                  ? 'لا يوجد أطباء حالياً. قم بإضافة طبيب جديد.'
                                  : 'No doctors yet. Please add a new doctor.',
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text(t.colDoctorName)),
                                DataColumn(label: Text(t.colSpecialty)),
                                DataColumn(label: Text(t.colRoom)),
                                DataColumn(label: Text(t.colPhone)),
                                DataColumn(label: Text(t.colNotes)),
                                DataColumn(label: Text(t.colActions)),
                              ],
                              rows: [
                                for (int i = 0; i < doctors.length; i++)
                                  _buildRow(
                                    context: context,
                                    index: i,
                                    doctor: doctors[i],
                                    t: t,
                                  ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildRow({
    required BuildContext context,
    required int index,
    required Doctor doctor,
    required AppText t,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(doctor.name)),
        DataCell(Text(doctor.specialty)),
        DataCell(Text(doctor.room)),
        DataCell(Text(doctor.phone)),
        DataCell(
          SizedBox(
            width: 220,
            child: Text(
              doctor.notes,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: t.save,
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () => _openDoctorForm(
                  context,
                  t.isArabic,
                  t,
                  existing: doctor,
                  index: index,
                ),
              ),
              IconButton(
                tooltip: t.delete,
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: () => _confirmDelete(context, index, t),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, int index, AppText t) {
    final isArabic = t.isArabic;
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(t.delete),
          content: Text(
            isArabic
                ? 'هل أنت متأكد من حذف بيانات هذا الطبيب؟'
                : 'Are you sure you want to delete this doctor?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(t.cancel),
            ),
            TextButton(
              onPressed: () {
                onDelete(index);
                Navigator.pop(ctx);
              },
              child: Text(t.delete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void _openDoctorForm(
    BuildContext context,
    bool isArabic,
    AppText t, {
    Doctor? existing,
    int? index,
  }) {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final specCtrl = TextEditingController(text: existing?.specialty ?? '');
    final roomCtrl = TextEditingController(text: existing?.room ?? '');
    final phoneCtrl = TextEditingController(text: existing?.phone ?? '');
    final notesCtrl = TextEditingController(text: existing?.notes ?? '');

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              existing == null ? t.formTitleAddDoctor : t.formTitleEditDoctor,
            ),
            content: SizedBox(
              width: 420,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelDoctorName,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: specCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelSpecialty,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: roomCtrl,
                        decoration: InputDecoration(labelText: t.labelRoom),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneCtrl,
                        decoration: InputDecoration(labelText: t.labelPhone),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: notesCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelDoctorNotes,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(t.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final d = Doctor(
                    name: nameCtrl.text.trim(),
                    specialty: specCtrl.text.trim(),
                    room: roomCtrl.text.trim(),
                    phone: phoneCtrl.text.trim(),
                    notes: notesCtrl.text.trim(),
                  );

                  if (existing == null) {
                    onAdd(d);
                  } else if (index != null) {
                    onUpdate(index, d);
                  }

                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: Text(t.save),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppointmentsDashboard extends StatelessWidget {
  final bool isArabic;
  final List<Appointment> appointments;
  final List<Patient> patients;
  final List<Doctor> doctors;
  final void Function(Appointment) onAdd;
  final void Function(int, Appointment) onUpdate;
  final void Function(int) onDelete;

  const AppointmentsDashboard({
    super.key,
    required this.isArabic,
    required this.appointments,
    required this.patients,
    required this.doctors,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppText(isArabic);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: isArabic
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                t.appointmentsTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                t.appointmentsSubtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    '${appointments.length}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isArabic
                        ? 'موعد مسجّل في النظام'
                        : 'appointments registered in the system',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () => _openAppointmentForm(context, isArabic, t),
                    icon: const Icon(Icons.event_available),
                    label: Text(t.btnAddAppointment),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: appointments.isEmpty
                        ? Center(
                            child: Text(
                              isArabic
                                  ? 'لا يوجد مواعيد حالياً. قم بإضافة موعد جديد.'
                                  : 'No appointments yet. Please add a new appointment.',
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text(t.colApptPatient)),
                                DataColumn(label: Text(t.colApptDoctor)),
                                DataColumn(label: Text(t.colApptDate)),
                                DataColumn(label: Text(t.colApptTime)),
                                DataColumn(label: Text(t.colApptStatus)),
                                DataColumn(label: Text(t.colActions)),
                              ],
                              rows: [
                                for (int i = 0; i < appointments.length; i++)
                                  _buildRow(
                                    context: context,
                                    index: i,
                                    appointment: appointments[i],
                                    t: t,
                                  ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildRow({
    required BuildContext context,
    required int index,
    required Appointment appointment,
    required AppText t,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(appointment.patientName)),
        DataCell(Text(appointment.doctorName)),
        DataCell(Text(appointment.date)),
        DataCell(Text(appointment.time)),
        DataCell(Text(appointment.status)),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: t.save,
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () => _openAppointmentForm(
                  context,
                  t.isArabic,
                  t,
                  existing: appointment,
                  index: index,
                ),
              ),
              IconButton(
                tooltip: t.delete,
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: () => _confirmDelete(context, index, t),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, int index, AppText t) {
    final isArabic = t.isArabic;
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(t.delete),
          content: Text(
            isArabic
                ? 'هل أنت متأكد من حذف هذا الموعد؟'
                : 'Are you sure you want to delete this appointment?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(t.cancel),
            ),
            TextButton(
              onPressed: () {
                onDelete(index);
                Navigator.pop(ctx);
              },
              child: Text(t.delete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void _openAppointmentForm(
    BuildContext context,
    bool isArabic,
    AppText t, {
    Appointment? existing,
    int? index,
  }) {
    final patientCtrl = TextEditingController(
      text: existing?.patientName ?? '',
    );
    final doctorCtrl = TextEditingController(text: existing?.doctorName ?? '');
    final dateCtrl = TextEditingController(text: existing?.date ?? '');
    final timeCtrl = TextEditingController(text: existing?.time ?? '');
    final statusCtrl = TextEditingController(text: existing?.status ?? '');

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              existing == null
                  ? t.formTitleAddAppointment
                  : t.formTitleEditAppointment,
            ),
            content: SizedBox(
              width: 420,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: patientCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelApptPatient,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: doctorCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelApptDoctor,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: dateCtrl,
                        decoration: InputDecoration(labelText: t.labelApptDate),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: timeCtrl,
                        decoration: InputDecoration(labelText: t.labelApptTime),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: statusCtrl,
                        decoration: InputDecoration(
                          labelText: t.labelApptStatus,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? t.errorRequired
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(t.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final a = Appointment(
                    patientName: patientCtrl.text.trim(),
                    doctorName: doctorCtrl.text.trim(),
                    date: dateCtrl.text.trim(),
                    time: timeCtrl.text.trim(),
                    status: statusCtrl.text.trim(),
                  );

                  if (existing == null) {
                    onAdd(a);
                  } else if (index != null) {
                    onUpdate(index, a);
                  }

                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: Text(t.save),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final bool isArabic;
  const LoginPage({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final t = AppText(isArabic);
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    bool remember = true;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.loginTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.loginSubtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(t.emailLabel),
                      const SizedBox(height: 6),
                      TextField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(t.passwordLabel),
                      const SizedBox(height: 6),
                      TextField(
                        controller: passCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: isArabic
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: remember,
                            onChanged: (v) {
                              setState(() {
                                remember = v ?? false;
                              });
                            },
                            visualDensity: VisualDensity.compact,
                          ),
                          Text(
                            t.rememberMe,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isArabic
                                      ? 'تم تسجيل الدخول بنجاح.'
                                      : 'Signed in successfully.',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(t.loginButton),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        t.loginInfo,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
