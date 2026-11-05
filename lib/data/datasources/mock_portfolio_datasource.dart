import 'package:flutter/material.dart';
import 'package:portfolio/data/models/education_model.dart';
import 'package:portfolio/data/models/experience_model.dart';
import 'package:portfolio/data/models/profile_model.dart';
import 'package:portfolio/data/models/project_model.dart';
import 'package:portfolio/data/models/skill_model.dart';

class MockPortfolioDatasource {
  // ---------------------------------------------------------------------------
  // Profile
  // ---------------------------------------------------------------------------
  ProfileModel getProfile() {
    return const ProfileModel(
      name: 'Osama Saeid',
      title: 'Junior Flutter Developer',
      email: 'osamasaeed283@gmail.com',
      phone: '01121823522',
      location: 'Kafr Alzayat - Tanta',
      bio:
          'Junior Flutter Developer experienced in building mobile and web applications '
          'using Flutter. Worked on healthcare, e-commerce, and web projects with strong '
          'knowledge of Bloc, Clean Architecture, API integration, Firebase, Supabase, '
          'and CI/CD. Focused on clean code, scalability, and performance.',
      linkedinUrl: 'https://linkedin.com/in/osama-elmulla',
      githubUrl: 'https://github.com/osama-elmulla',
      avatarUrl: 'assets/images/avatar.png',
    );
  }

  // ---------------------------------------------------------------------------
  // Experience
  // ---------------------------------------------------------------------------
  List<ExperienceModel> getExperience() {
    return const [
      ExperienceModel(
        title: 'Mobile Application Development Trainee',
        company: 'Information Technology Institute (ITI)',
        duration: '2024',
        description:
            'Intensive training program focused on mobile application development '
            'using Flutter and Dart. Gained hands-on experience in building '
            'cross-platform applications with modern architectures, state '
            'management solutions, and best practices for production-ready apps. '
            'Collaborated with fellow trainees on real-world projects and '
            'participated in code reviews and agile development workflows.',
      ),
      ExperienceModel(
        title: 'Mobile Application Development Trainee',
        company: 'Digital Egyptian Pioneers Initiative (DEPI)',
        duration: '2024',
        description:
            'Participated in the Digital Egyptian Pioneers Initiative program '
            'focusing on Flutter mobile development. Developed practical skills '
            'in building scalable mobile applications, integrating RESTful APIs, '
            'implementing Firebase and Supabase backends, and applying Clean '
            'Architecture patterns. Worked on team-based projects simulating '
            'real-world software development environments.',
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Projects
  // ---------------------------------------------------------------------------
  List<ProjectModel> getProjects() {
    return const [
      ProjectModel(
        title: 'Alfolk App',
        subtitle: 'Graduation Project (iOS & Android)',
        description:
            'A comprehensive Flutter platform developed for Alfolk Foundation, '
            'dedicated to supporting children with Down syndrome. The app features '
            'interactive educational games designed to enhance learning and cognitive '
            'development, progress tracking for parents and educators, medication '
            'reminders to ensure consistent care, and an AI-powered assistant for '
            'guidance and support. Built with Clean Architecture principles and Bloc '
            'state management for a robust, maintainable codebase.',
        technologies: [
          'Flutter',
          'Dart',
          'Clean Architecture',
          'Bloc',
          'REST APIs',
          'AI Integration',
        ],
        achievements: [
          'Presented before University President',
          'Featured in TV interviews',
          'Graduation project for Faculty of Computers and Information',
          'Interactive educational games for children with Down syndrome',
          'AI-powered assistant for guidance and support',
          'Medication reminders and progress tracking',
        ],
        platforms: ['iOS', 'Android'],
        iconData: Icons.child_care_rounded,
      ),
      ProjectModel(
        title: 'Healora',
        subtitle: 'Healthcare Mobile Application (iOS & Android)',
        description:
            'A full-featured healthcare application providing seamless interaction '
            'between patients and doctors. Includes patient and doctor account '
            'management, appointment scheduling and tracking, comprehensive medical '
            'history records, an AI-powered Gemini chatbot for health inquiries, '
            'push notifications for appointment reminders, and support for both '
            'light and dark themes. Integrates Firebase for authentication and '
            'real-time data, Supabase for backend services, and implements CI/CD '
            'pipelines for automated deployment.',
        technologies: [
          'Flutter',
          'Dart',
          'Clean Architecture',
          'Bloc',
          'Firebase',
          'Supabase',
          'CI/CD',
          'Gemini AI',
          'Push Notifications',
        ],
        achievements: [
          'Patient and doctor account management',
          'Appointment scheduling and tracking system',
          'AI-powered Gemini chatbot for health inquiries',
          'Push notification system for appointment reminders',
          'Light and dark theme support',
          'CI/CD pipeline for automated deployments',
        ],
        platforms: ['iOS', 'Android'],
        iconData: Icons.local_hospital_rounded,
      ),
      ProjectModel(
        title: 'FCI Rovers',
        subtitle: 'Flutter Web App',
        description:
            'A web application built for student registration in scouting '
            'activities at the Faculty of Computers and Information. Provides '
            'an intuitive interface for students to browse available scouting '
            'events, register for activities, and manage their participation. '
            'Features include user authentication, event listing, registration '
            'management, and admin controls. Built with Clean Architecture, '
            'Bloc state management, Supabase backend, and CI/CD integration '
            'for seamless deployment.',
        technologies: [
          'Flutter Web',
          'Dart',
          'Clean Architecture',
          'Bloc',
          'Supabase',
          'CI/CD',
        ],
        achievements: [
          'Student registration system for scouting activities',
          'Event listing and management',
          'User authentication and role-based access',
          'Admin dashboard for managing registrations',
          'Responsive web design',
        ],
        platforms: ['Web'],
        iconData: Icons.explore_rounded,
      ),
      ProjectModel(
        title: 'Alharamin App',
        subtitle: 'Healthcare Booking Application',
        description:
            'A healthcare booking application that simplifies the process of '
            'scheduling medical appointments. Features an admin dashboard for '
            'managing healthcare providers and appointments, and an integrated '
            'Gemini chatbot for patient inquiries and guidance. Built with Flutter '
            'and Firebase for real-time data synchronization, authentication, and '
            'cloud storage, following Clean Architecture principles and Bloc '
            'pattern for state management.',
        technologies: [
          'Flutter',
          'Dart',
          'Firebase',
          'Clean Architecture',
          'Bloc',
          'Gemini AI',
        ],
        achievements: [
          'Healthcare appointment booking system',
          'Admin dashboard for managing providers',
          'AI-powered Gemini chatbot for patient guidance',
          'Real-time data synchronization with Firebase',
          'Role-based access control',
        ],
        platforms: ['iOS', 'Android'],
        iconData: Icons.medical_services_rounded,
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Skills
  // ---------------------------------------------------------------------------
  List<SkillModel> getSkills() {
    return const [
      // Technical Skills
      SkillModel(
        name: 'Dart',
        percentage: 0.90,
        category: 'technical',
        iconData: Icons.code_rounded,
      ),
      SkillModel(
        name: 'Flutter',
        percentage: 0.88,
        category: 'technical',
        iconData: Icons.flutter_dash_rounded,
      ),
      SkillModel(
        name: 'Firebase',
        percentage: 0.82,
        category: 'technical',
        iconData: Icons.local_fire_department_rounded,
      ),
      SkillModel(
        name: 'Supabase',
        percentage: 0.78,
        category: 'technical',
        iconData: Icons.storage_rounded,
      ),
      SkillModel(
        name: 'Git & GitHub',
        percentage: 0.85,
        category: 'technical',
        iconData: Icons.account_tree_rounded,
      ),
      SkillModel(
        name: 'Hive',
        percentage: 0.75,
        category: 'technical',
        iconData: Icons.inventory_2_rounded,
      ),
      SkillModel(
        name: 'Cubit / Bloc',
        percentage: 0.88,
        category: 'technical',
        iconData: Icons.hub_rounded,
      ),
      SkillModel(
        name: 'Clean Architecture',
        percentage: 0.85,
        category: 'technical',
        iconData: Icons.architecture_rounded,
      ),
      SkillModel(
        name: 'REST APIs',
        percentage: 0.82,
        category: 'technical',
        iconData: Icons.api_rounded,
      ),
      SkillModel(
        name: 'CI/CD',
        percentage: 0.72,
        category: 'technical',
        iconData: Icons.loop_rounded,
      ),

      // Soft Skills
      SkillModel(
        name: 'Communication Skills',
        percentage: 0.90,
        category: 'soft',
        iconData: Icons.chat_rounded,
      ),
      SkillModel(
        name: 'Presentation Skills',
        percentage: 0.88,
        category: 'soft',
        iconData: Icons.present_to_all_rounded,
      ),
      SkillModel(
        name: 'Time Management',
        percentage: 0.85,
        category: 'soft',
        iconData: Icons.schedule_rounded,
      ),
      SkillModel(
        name: 'Problem Solving',
        percentage: 0.87,
        category: 'soft',
        iconData: Icons.psychology_rounded,
      ),
      SkillModel(
        name: 'Teamwork',
        percentage: 0.92,
        category: 'soft',
        iconData: Icons.group_rounded,
      ),
      SkillModel(
        name: 'Leadership',
        percentage: 0.85,
        category: 'soft',
        iconData: Icons.leaderboard_rounded,
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Education
  // ---------------------------------------------------------------------------
  List<EducationModel> getEducation() {
    return const [
      EducationModel(
        degree: "Bachelor's Degree in Computer Science",
        institution: 'Faculty of Computers and Information, Tanta University',
        year: '2022 - 2026',
        description:
            'Studied Computer Science with focus on software engineering, '
            'data structures, algorithms, and mobile application development. '
            'Graduated with a strong foundation in programming principles and '
            'modern software architecture patterns.',
        courses: [
          'Mobile App Development (Flutter) - Eng. Tharwat Samy',
          'English Intermediate (B2) - UCCD AUC',
        ],
        volunteerWork: [
          'Vice head of culture committee in Student Union (2022-2023 & 2023-2024)',
          'Leader of the college Scout team and university team',
          'Ideal Student Award at the college in 2025',
        ],
      ),
      EducationModel(
        degree: 'Mobile App Development Training',
        institution: 'Information Technology Institute (ITI)',
        year: '2024',
        description:
            'Intensive training in mobile application development using Flutter '
            'and Dart. Covered state management, API integration, database '
            'management, and best practices for cross-platform development.',
      ),
      EducationModel(
        degree: 'Mobile App Development Training',
        institution: 'Digital Egyptian Pioneers Initiative (DEPI)',
        year: '2024',
        description:
            'Comprehensive training program under the Egyptian government '
            'initiative focusing on digital skills development. Specialized '
            'in Flutter mobile development with emphasis on real-world project '
            'delivery and professional software development practices.',
      ),
      EducationModel(
        degree: 'Mobile App Development Course',
        institution: 'Udemy - Eng. Tharwat Samy',
        year: '2023',
        description:
            'Completed comprehensive mobile app development course taught by '
            'Eng. Tharwat Samy on Udemy. Covered Dart programming, Flutter '
            'framework fundamentals, widget development, state management, '
            'and building production-ready mobile applications.',
      ),
      EducationModel(
        degree: 'English Intermediate Certificate',
        institution: 'UCCD – The American University in Cairo',
        year: '2023',
        description:
            'Completed English intermediate level certification at the University '
            'Center for Continuing Development (UCCD) at The American University '
            'in Cairo. Enhanced English communication, writing, and presentation '
            'skills to a B2 proficiency level.',
      ),
    ];
  }
}
