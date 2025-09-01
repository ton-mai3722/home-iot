# home_iot
🏡 IoT Home Control Application

แอปพลิเคชัน Flutter สำหรับควบคุมและสั่งงานอุปกรณ์ IoT ภายในบ้าน เช่น ไฟฟ้า แอร์ พัดลม กล้องวงจรปิด ฯลฯ
โฟกัสไปที่การใช้งานง่าย UI ที่เป็นมิตร และการเชื่อมต่อกับอุปกรณ์ IoT ผ่าน API / MQTT

🚀 Features

ระบบ Splash Screen

ระบบ Authentication (Login / Sign Up)

Dashboard Home สำหรับควบคุมอุปกรณ์

ระบบ Room แยกตามห้องต่าง ๆ (เช่น ห้องนอน ห้องครัว)

หน้า Profile สำหรับจัดการข้อมูลผู้ใช้

📂 Pages & Structure
1. Splash Screen

สิ่งที่ควรมี:

โลโก้แอป + Animation (Fade/Slide)

โหลดค่าที่จำเป็น เช่น Token, ค่า Config IoT

Redirect ไปยัง Login หรือ Home (ถ้าเคย Login แล้ว)

2. Login Page

สิ่งที่ควรมี:

Input: Email / Password

ปุ่ม Login

ปุ่ม "Sign Up" สำหรับไปสมัครสมาชิก

ปุ่ม "Forgot Password"

Social Login (ถ้าต้องการ เช่น Google/Apple)

3. Sign Up Page

สิ่งที่ควรมี:

Input: ชื่อผู้ใช้, Email, Password, Confirm Password

ปุ่ม Sign Up

Redirect ไปหน้า Login หลังสมัครสำเร็จ

Validation (เช่น Password >= 6 ตัวอักษร)

4. Home Page (Dashboard)

สิ่งที่ควรมี:

สรุปสถานะอุปกรณ์ทั้งหมด เช่น จำนวนอุปกรณ์ที่เปิด/ปิด

Quick Access ปุ่มสั่งงานด่วน (เช่น ปิดไฟทั้งหมด)

การ์ดแต่ละห้อง (Room) พร้อม Shortcut

เมนูไปหน้า Profile

5. Room Page (เช่น ห้องนอน, ห้องนั่งเล่น)

สิ่งที่ควรมี:

ชื่อห้อง + Icon

รายการอุปกรณ์ (เช่น Light, Air Conditioner, Fan)

Switch / Slider / Button สำหรับควบคุมอุปกรณ์

การแสดงสถานะอุปกรณ์ (On/Off, Temp, Brightness)

6. Profile Page

สิ่งที่ควรมี:

ข้อมูลผู้ใช้: ชื่อ, อีเมล, รูปโปรไฟล์

ปุ่มแก้ไขข้อมูล

Settings (ภาษา, ธีม, Notification)

ปุ่ม Logout

// Project Structure

lib/
  main.dart                // App entry point
  injection.dart           // Dependency Injection setup (GetIt or Riverpod)

  core/                    // Core utilities & common code
    errors/                // Exception, Failure classes
    usecases/              // Base UseCase class
    constants/             // App constants (colors, strings, etc.)
    utils/                 // Helper functions (validators, formatters, etc.)

  features/                // Each feature is modular
    auth/                  // Authentication Module (Login/SignUp)
      domain/
        entities/          // User entity
        repositories/      // Abstract AuthRepository
        usecases/          // Login, SignUp, Logout use cases
      data/
        models/            // UserModel (from JSON)
        datasources/       // Remote / Local Data Sources
        repositories/      // AuthRepositoryImpl
      presentation/
        bloc/    // State management
        pages/             // LoginPage, SignUpPage
        widgets/           // Auth-related widgets

    splash/
      presentation/
        pages/             // SplashScreen
        Bloc/             // SplashBloc (check auth state, load configs)

    home/
      domain/
        entities/          // Device, Room
        repositories/      // Abstract DeviceRepository
        usecases/          // GetDevices, ToggleDevice, etc.
      data/
        models/            // DeviceModel, RoomModel
        datasources/       // DeviceRemoteDataSource, DeviceLocalDataSource
        repositories/      // DeviceRepositoryImpl
      presentation/
        bloc/    // HomeBloc
        pages/             // HomePage
        widgets/           // RoomCard, DeviceCard

    room/
      domain/
        entities/          // Room, Device
        repositories/      // RoomRepository
        usecases/          // GetRoomDevices, UpdateDeviceState
      data/
        models/            // RoomModel, DeviceModel
        datasources/       // RoomRemoteDataSource
        repositories/      // RoomRepositoryImpl
      presentation/
        bloc/   // RoomBloc
        pages/             // RoomPage
        widgets/           // DeviceControls (switch, slider, etc.)

    profile/
      domain/
        entities/          // Profile entity
        repositories/      // ProfileRepository
        usecases/          // GetProfile, UpdateProfile, Logout
      data/
        models/            // ProfileModel
        datasources/       // ProfileRemoteDataSource
        repositories/      // ProfileRepositoryImpl
      presentation/
        bloc/    // ProfileBloc
        pages/             // ProfilePage
        widgets/           // ProfileForm, ProfileHeader

  shared/                  // Reusable shared widgets
    widgets/
    styles/
    themes/
