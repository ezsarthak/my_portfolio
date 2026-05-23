class PortfolioData {
  // Personal
  static const String name = 'Sarthak Patil';
  static const String firstName = 'Sarthak';
  static const String tagline = 'Flutter + Backend + AI | Startup Founder';
  static const String bio =
      'I am a Developer focused on real-world problem solving through scalable technology. I am passionate about healthcare tech, AI systems, and real-time applications. With strong product thinking and UI/UX focus, I prefer solving practical real-world problems over demo projects. I am also an active open-source contributor with experience in deployment, backend APIs, authentication, and cloud infrastructure.';
  static const String email = 'sarthak05patil@gmail.com';
  static const String phone = '+91 7447417740';
  static const String location = 'India';
  static const String university =
      'Indian Institute of Information Technology, Bhopal';
  static const String degree = 'B.Tech in Information Technology';
  static const String graduationYear = '2028';
  static const String resumeUrl = 'https://bit.ly/ezsarthak_resume';

  // Social
  static const String github = 'https://github.com/ezsarthak';
  static const String linkedin = 'https://www.linkedin.com/in/ezsarthak';
  static const String twitter = 'https://x.com/ezsarthak';
  static const String leetcode = '#';
  static const String medium = 'https://medium.com/@ezsarthak';
  static const String youtube = 'https://www.youtube.com/@ezsarthak';
  static const String instagram = '#';

  // Stats
  static const List<Map<String, String>> quickStats = [
    {
      'value': '15+',
      'label': 'Projects Built',
      'image': 'assets/images/bulb_image.png'
    },
    {
      'value': '4',
      'label': 'Internships',
      'image': 'assets/images/cup_image.png'
    },
    {
      'value': '1',
      'label': 'Startup',
      'image': 'assets/images/picker_image.png'
    },
    {
      'value': '180',
      'label': 'GSSOC Rank (In 4000+)',
      'image': 'assets/images/bookmark_image.png'
    },
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
    'company': 'Veroz Social',
    'role': 'Software Developer Intern',
    'duration': 'Mar 2026 - Present',
    'description':
        'Built and optimized a cross-platform mobile application from an existing web platform using Flutter WebView integration. Improved responsiveness, navigation flow, and app performance for Android devices.',
  },
  {
    'company': 'Subscart',
    'role': 'Junior Flutter Developer',
    'duration': 'Nov 2025 - Dec 2025',
    'description':
        'Developed scalable coupon and subscription workflows integrated with REST APIs. Refactored application state management using Provider architecture and designed interactive onboarding experiences to improve user engagement.',
  },
  {
    'company': 'S.Rocks.Music',
    'role': 'Flutter Developer Intern',
    'duration': 'Jun 2025 - Jul 2025',
    'description':
        'Implemented secure Firebase Authentication and modernized legacy Flutter modules using GetX and MVVM architecture. Designed gamified onboarding screens to enhance user retention and first-time experience.',
  },
  {
    'company': 'Fiel',
    'role': 'App Development Lead Intern',
    'duration': 'Dec 2024 - Jan 2025',
    'description':
        'Led a 5-member Agile development team for a location-based application. Designed 15+ production-ready Figma screens and engineered high-accuracy real-time location tracking and map integration workflows.',
  }
];

  // Dev Projects
static const List<Map<String, dynamic>> devProjects = [
  {
    'title': 'Monavi — Healthcare Ecosystem',
    'description':
        'Digital prescription ecosystem. Engineered secure REST APIs, JWT authentication, capable of handling 1,000+ concurrent records.',
    'github': 'https://github.com/ezsarthak',
    'live': 'https://monavi.in',
    'image': 'assets/project_icons/monavi.png',
    'tech': [
      'Flutter',
      'Node.js',
      'Express.js',
      'PostgreSQL',
      'JWT Auth',
      'REST APIs',
      'Encryption'
    ],
    'technicalDetails': [
      'Engineered secure REST APIs & JWT authentication.',
      'Capable of handling 1,0000+ concurrent records.',
      'Integrated HIPAA-compliant encryption algorithms.'
    ],
  },
  {
    'title': 'Kochi Metro — Predictive Maintenance',
    'description':
        'AI-powered metro maintenance prediction predicting high-risk failures. Improved scheduling accuracy by 30%.',
    'github': 'https://github.com/ezsarthak/kochi_metro_supervisor',
    'image': 'assets/project_icons/kochi.png',
    'tech': [
      'Python',
      'TensorFlow',
      'LSTM',
      'FastAPI',
      'LangChain',
      'LangGraph',
      'Telemetry Processing'
    ],
    'technicalDetails': [
      'AI-powered metro maintenance prediction system.',
      'Improved scheduling accuracy by 30% using LSTM.',
      'Real-time telemetry data processing workflows.'
    ],
  },
  {
    'title': 'Draw It',
    'description':
        'Real-time collaborative canvas app on Play Store. Synchronization under 10ms latency using Socket.io and Clean Architecture.',
    'github': 'https://github.com/ezsarthak/draw_it',
    'live':
        'https://play.google.com/store/apps/details?id=dev.sarthak.drawit',
    'image': 'assets/project_icons/drawit.png',
    'stars': '4.6',
    'downloads': '100+',
    'tech': [
      'Flutter',
      'Socket.io',
      'Node.js',
      'MongoDB',
      'WebSockets',
      'Clean Architecture',
      'State Management'
    ],
    'technicalDetails': [
      'Real-time collaborative canvas app on Play Store.',
      'Synchronization under 10ms latency using WebSocket/Socket.io.',
      'Built using clean architecture and state management.'
    ],
  },
  {
    'title': 'Pulse Mate',
    'description':
        'Full-stack dating application with real-time chat and JWT authentication.',
    'github': 'https://github.com/ezsarthak/pulse_mate',
    'image': 'assets/project_icons/pulse_mate.png',
    'tech': [
      'Flutter',
      'Node.js',
      'Express.js',
      'Socket.io',
      'JWT Auth',
      'MongoDB',
      'Matching Algorithms'
    ],
    'technicalDetails': [
      'Full-stack dating application.',
      'Real-time chat and JWT secure authentication.',
      'Intelligent local matching and swipe-filtering logic.'
    ],
  },
  {
    'title': 'Eco Cycle',
    'description':
        'AI-based recycle/reuse item prediction system built during GSC project.',
    'github': 'https://github.com/ezsarthak/Eco_Cycle',
    'image': 'assets/project_icons/eco_cycle.PNG',
    'tech': [
      'Python',
      'TensorFlow',
      'Computer Vision',
      'Flutter',
      'Image Classification',
      'Machine Learning'
    ],
    'technicalDetails': [
      'AI-based recycle/reuse item prediction system.',
      'Built during Google Solution Challenge.',
      'Computer vision models for plastic and item recognition.'
    ],
  },
  {
    'title': 'SMS Seva',
    'description':
        'Civic issue reporting platform. Voice/SMS-based complaint system for accessibility. Social impact focused project.',
    'github': 'https://github.com/ezsarthak/smseva',
    'tech': [
      'Flutter',
      'Node.js',
      'Express.js',
      'Twilio API',
      'MongoDB',
      'SMS Automation',
      'Accessibility Systems'
    ],
    'technicalDetails': [
      'Voice/SMS-based civic complaint reporting platform.',
      'Integrated Twilio APIs for real-time SMS workflows.',
      'Accessibility-focused system for low-internet regions.',
      'Backend complaint tracking and issue escalation modules.'
    ],
  },
  {
    'title': 'Clinical Note',
    'description':
        'IIIT inter-college project. AI-assisted diagnosis prediction system. Healthcare-focused prediction workflows.',
    'github': 'https://github.com/ezsarthak/clinical_note',
    'tech': [
      'Python',
      'PyTorch',
      'Django',
      'NLP',
      'Machine Learning',
      'Prediction Models',
      'Healthcare AI'
    ],
    'technicalDetails': [
      'AI-assisted diagnosis prediction and clinical note analysis.',
      'Implemented healthcare-focused NLP prediction workflows.',
      'Built ML pipelines for symptom-to-disease correlation.',
      'Developed secure Django backend for patient record handling.'
    ],
  }
];

  static const List<Map<String, dynamic>> freelanceProjects = [
    {
      'title': 'KWCH',
      'description':
          'Preview and Plugin Dashboard for Kustom apps including UI implementation and API integrations.',
      'client': 'Confidential',
    },
    {
      'title': 'Wall App + Admin Panel',
      'description':
          'Developed user-facing wallpaper app using external APIs and a separate admin management system.',
      'client': 'Freelance',
    }
  ];

  // Blogs
  static const List<Map<String, String>> blogs = [
    {
      'title': 'Scheduling Local Notifications in Flutter (The Right Way)',
      'date': 'Recent Article',
      'description':
          'A comprehensive guide on implementing and scheduling local notifications accurately in your Flutter applications using best practices.',
      'link':
          'https://medium.com/@ezsarthak/scheduling-local-notifications-in-flutter-the-right-way-8b99b1a72866'
    }
  ];

  // Config Toggles
  static const bool showDsaSection = false;
}
