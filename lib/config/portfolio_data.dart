class PortfolioData {
  // Personal
  static const String name = 'Sarthak Patil';
  static const String firstName = 'Sarthak';
  static const String tagline = 'Flutter + Backend + AI | Turning ideas into deployed products.';
  static const String bio =
      'I am a Developer focused on real-world problem solving through scalable technology. I am passionate about healthcare tech, AI systems, and real-time applications. With strong product thinking and UI/UX focus, I prefer solving practical real-world problems over demo projects. I am also an active open-source contributor with experience in deployment, backend APIs, authentication, and cloud infrastructure.';
  static const String email = 'sarthak05patil@gmail.com';
  static const String phone = '+91 7447417740';
  static const String location = 'India';
  static const String university = 'Indian Institute of Information Technology, Bhopal';
  static const String degree = 'B.Tech in Information Technology';
  static const String graduationYear = '2028';
  static const String resumeUrl = 'https://bit.ly/ezsarthak_resume';

  // Social
  static const String github = 'https://github.com/ezsarthak';
  static const String linkedin = 'https://www.linkedin.com/in/sarthaknpatil';
  static const String twitter = '#';
  static const String leetcode = '#';
  static const String youtube = '#';

  // Stats
  static const List<Map<String, String>> quickStats = [
    {'value': '15+', 'label': 'Projects Built', 'image': 'assets/images/bulb_image.png'},
    {'value': '4', 'label': 'Internships', 'image': 'assets/images/cup_image.png'},
    {'value': '1', 'label': 'Startup', 'image': 'assets/images/picker_image.png'},
    {'value': '4000+', 'label': 'GSSOC Rank (Top 5%)', 'image': 'assets/images/bookmark_image.png'},
  ];

  // Startup
  static const Map<String, dynamic> startup = {
    'name': 'Monavi',
    'tagline': 'Digital prescription ecosystem for doctors and patients',
    'description':
        'Monavi is a scalable healthcare ecosystem serving digital prescriptions, patient records, and doctor workflow automation. It focuses on practical UX for overloaded doctors to reduce manual clinical processing time and improve operational efficiency.',
    'role': 'Founder / Core Developer',
    'status': 'Active',
    'metrics': {
      'Stage': 'Building Phase',
      'Team': 'Core Only',
    }
  };

  // Internships
  static const List<Map<String, String>> internships = [
    {
      'company': 'Subscart',
      'role': 'Junior Flutter Developer',
      'duration': 'Nov 2025 - Dec 2025',
      'description': 'Architected scalable Coupon Code system via REST APIs. Migrated state to Provider. Designed interactive onboarding flow.',
    },
    {
      'company': 'S RocksMusic',
      'role': 'Flutter Developer Intern',
      'duration': 'Jun 2025 - Jul 2025',
      'description': 'Developed robust Firebase Auth. Refactored legacy codebase using GetX and MVVM. Created gamified onboarding.',
    },
    {
      'company': 'Fiel',
      'role': 'AppDev Lead Intern',
      'duration': 'Dec 2024 - Jan 2025',
      'description': 'Led a 5-member cross-functional Agile team. Designed 15+ Figma screens. Engineered high-precision location tracking.',
    },
    {
      'company': 'Veroz Social',
      'role': 'Flutter Intern',
      'duration': 'Internship',
      'description': 'Converted website into a cross-platform mobile app using WebView integration and optimization.',
    }
  ];

  // Dev Projects
  static const List<Map<String, dynamic>> devProjects = [
    {
      'title': 'Monavi — Healthcare Ecosystem',
      'description': 'Digital prescription ecosystem. Engineered secure REST APIs, JWT authentication, capable of handling 1,000+ concurrent records.',
      'github': 'https://github.com/ezsarthak',
      'live': '#',
      'image': 'assets/project_icons/monavi.png',
    },
    {
      'title': 'Kochi Metro — Predictive Maintenance',
      'description': 'AI-powered metro maintenance prediction predicting high-risk failures. Improved scheduling accuracy by 30%.',
      'github': 'https://github.com/ezsarthak',
      'live': '#',
      'image': 'assets/project_icons/kochi.png',
    },
    {
      'title': 'Draw It',
      'description': 'Real-time collaborative canvas app on Play Store. Synchronization under 10ms latency using Socket.io and Clean Architecture.',
      'github': 'https://github.com/ezsarthak',
      'live': '#',
      'image': 'assets/project_icons/drawit.png',
    },
    {
      'title': 'Pulse Mate',
      'description': 'Full-stack dating application with real-time chat and JWT authentication.',
      'github': '#',
      'live': '#',
      'image': 'assets/project_icons/pulse_mate.png',
    },
    {
      'title': 'Eco Cycle',
      'description': 'AI-based recycle/reuse item prediction system built during GSC project.',
      'github': '#',
      'live': '#',
      'image': 'assets/project_icons/eco_cycle.PNG',
    },
    {
      'title': 'SMS Seva',
      'description': 'Civic issue reporting platform. Voice/SMS-based complaint system for accessibility. Social impact focused project.',
      'github': '#',
      'live': '#',
    },
    {
      'title': 'Clinical Note',
      'description': 'IIIT inter-college project. AI-assisted diagnosis prediction system. Healthcare-focused prediction workflows.',
      'github': '#',
      'live': '#',
    }
  ];

  static const List<Map<String, dynamic>> freelanceProjects = [
    {
      'title': 'KWCH',
      'description': 'Client-based cross-platform Flutter development work including UI implementation and API integrations.',
      'client': 'Confidential',
    },
    {
      'title': 'Wall App + Admin Panel',
      'description': 'Developed user-facing wallpaper app using external APIs and a separate admin management system.',
      'client': 'Freelance',
    }
  ];

  // Blogs
  static const List<Map<String, String>> blogs = [
    {
      'title': 'Scheduling Local Notifications in Flutter (The Right Way)',
      'date': 'Recent Article',
      'description': 'A comprehensive guide on implementing and scheduling local notifications accurately in your Flutter applications using best practices.',
      'link': 'https://medium.com/@ezsarthak/scheduling-local-notifications-in-flutter-the-right-way-8b99b1a72866'
    }
  ];

  // Config Toggles
  static const bool showDsaSection = false;
}
