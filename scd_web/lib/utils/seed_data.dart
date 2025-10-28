import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';

/// Utility script to seed Firestore with sample data for testing.
/// Run this once to populate your database with initial content.
class FirestoreSeedData {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Seeds all collections with sample data
  static Future<void> seedAllData() async {
    try {
      await seedAppContent();
      await seedStaff();
      await seedEvents();
      await seedPillars();
      await seedSponsors();
      await seedGalleryItems();
      developer.log('All data seeded successfully!', name: 'FirestoreSeed');
    } catch (e) {
      developer.log('Error seeding data', error: e, name: 'FirestoreSeed');
      rethrow;
    }
  }

  /// Seeds the app_content collection
  static Future<void> seedAppContent() async {
    await _db.collection('app_content').doc('main').set({
      'missionStatement':
          'Our mission is to use the performing arts as a vehicle for youth development. We aim to foster discipline, self-expression, leadership, and community engagement. SCD empowers young people to become responsible citizens and leaders of tomorrow.',
      'visionStatement':
          'To be a leading force in youth development through the performing arts, recognized for our artistic excellence and profound community impact. We envision a future where every member of our corps has the confidence, character, and skills to achieve their full potential.',
      'history':
          'Founded with a passion for rhythm and a commitment to our youth, Shark City Drum & Dance Corps has grown from a small community group into a beacon of artistic excellence and mentorship. We provide a structured, supportive environment where young performers can hone their craft, build lifelong friendships, and develop the character needed to succeed in all aspects of life. For years, we have served the community through countless performances, workshops, and outreach programs, leaving a lasting legacy of empowerment and artistic expression.',
      'joinUsTitle': 'Become a Part of the Rhythm',
      'joinUsText':
          'Are you ready to challenge yourself, learn new skills, and join an unforgettable team? Shark City Drum & Dance Corps is always looking for dedicated and passionate young performers to join our family. Whether you are an experienced drummer, a talented dancer, or a complete beginner with a willingness to learn, there is a place for you here. Auditions are held seasonally, and we encourage all interested youth to reach out. Contact us today to learn more about our next audition dates and how you can begin your journey with SCD.',
    });
    developer.log('App content seeded', name: 'FirestoreSeed');
  }

  /// Seeds the staff collection
  static Future<void> seedStaff() async {
    final staff = [
      {
        'name': 'Ronald Clark',
        'role': 'Executive Director',
        'bio':
            'With over 20 years of experience in youth mentorship and performing arts management, Ronald leads SCD with a vision for excellence and community impact.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=RC',
        'displayOrder': 1,
      },
      {
        'name': 'Angela Hill',
        'role': 'VP of Performance',
        'bio':
            'Angela brings exceptional choreography skills and a passion for developing young talent. She has led SCD to numerous competition victories.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=AH',
        'displayOrder': 2,
      },
      {
        'name': 'Jermaine T.',
        'role': 'Drum Instructor',
        'bio':
            'Jermaine is a master percussionist with performance experience across multiple genres. He specializes in technique and ensemble coordination.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=JT',
        'displayOrder': 3,
      },
      {
        'name': 'Darrin H.',
        'role': 'Drum Instructor',
        'bio':
            'Darrin focuses on rhythm fundamentals and musical theory, ensuring our drummers have a strong foundation.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=DH',
        'displayOrder': 4,
      },
      {
        'name': 'Myles R.',
        'role': 'Drum Instructor',
        'bio':
            'Myles brings energy and creativity to every rehearsal, specializing in contemporary drumline techniques.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=MR',
        'displayOrder': 5,
      },
      {
        'name': 'Rianna M.',
        'role': 'Dance Instructor',
        'bio':
            'Rianna is a trained professional dancer with expertise in multiple styles including contemporary, hip-hop, and jazz.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=RM',
        'displayOrder': 6,
      },
      {
        'name': 'Ciji R.',
        'role': 'Board Member',
        'bio':
            'Ciji serves on the board bringing expertise in nonprofit management and community outreach.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=CR',
        'displayOrder': 7,
      },
      {
        'name': 'Mika S.',
        'role': 'Board Member',
        'bio':
            'Mika contributes strategic planning and fundraising expertise to support SCD\'s growth and sustainability.',
        'photoUrl': 'https://via.placeholder.com/200x200?text=MS',
        'displayOrder': 8,
      },
    ];

    for (var member in staff) {
      await _db.collection('staff').add(member);
    }
    developer.log('Staff members seeded', name: 'FirestoreSeed');
  }

  /// Seeds the events collection
  static Future<void> seedEvents() async {
    final now = DateTime.now();
    final events = [
      {
        'title': 'Annual Winter Showcase',
        'date': Timestamp.fromDate(DateTime(now.year, 12, 15, 19, 0)),
        'locationName': 'The Grand Civic Auditorium',
        'locationAddress': '123 Main St, Norfolk, VA 23510',
        'description':
            'Join us for our annual winter showcase featuring performances by all our ensembles. This event highlights the hard work and dedication of our members throughout the season.',
        'imageUrl': 'https://via.placeholder.com/600x400?text=Winter+Showcase',
        'type': 'Performance',
      },
      {
        'title': 'Spring Auditions',
        'date': Timestamp.fromDate(DateTime(now.year + 1, 3, 10, 14, 0)),
        'locationName': 'SCD Rehearsal Hall',
        'locationAddress': '456 Oak Ave, Norfolk, VA 23510',
        'description':
            'Open auditions for new members! All skill levels welcome. Come prepared to demonstrate your passion and potential.',
        'imageUrl': 'https://via.placeholder.com/600x400?text=Auditions',
        'type': 'Audition',
      },
      {
        'title': 'Community Block Party Performance',
        'date': Timestamp.fromDate(DateTime(now.year, now.month + 1, 20, 15, 0)),
        'locationName': 'Downtown Norfolk',
        'locationAddress': 'Main Street, Norfolk, VA',
        'description':
            'Free community performance at the annual Norfolk Block Party. Bring the family and enjoy music, dance, and community spirit!',
        'imageUrl':
            'https://via.placeholder.com/600x400?text=Community+Event',
        'type': 'Community Event',
      },
      {
        'title': 'Drumline Workshop Series',
        'date': Timestamp.fromDate(DateTime(now.year, now.month + 2, 5, 10, 0)),
        'locationName': 'SCD Rehearsal Hall',
        'locationAddress': '456 Oak Ave, Norfolk, VA 23510',
        'description':
            'Four-week intensive workshop series focusing on advanced drumline techniques. Open to intermediate and advanced players.',
        'imageUrl': 'https://via.placeholder.com/600x400?text=Workshop',
        'type': 'Workshop',
      },
    ];

    for (var event in events) {
      await _db.collection('events').add(event);
    }
    developer.log('Events seeded', name: 'FirestoreSeed');
  }

  /// Seeds the pillars collection
  static Future<void> seedPillars() async {
    final pillars = [
      {
        'title': 'DISCIPLINE',
        'description':
            'Building character, focus, and a strong work ethic through structured practice and dedication to the craft.',
        'imageAssetPath': 'assets/pillar1.png',
        'displayOrder': 1,
      },
      {
        'title': 'TEAMWORK',
        'description':
            'Collaborating for success, supporting one another, and achieving excellence together as a unified corps.',
        'imageAssetPath': 'assets/pillar2.png',
        'displayOrder': 2,
      },
      {
        'title': 'ARTISTRY',
        'description':
            'Fostering creativity, self-expression, and performance excellence in both drumming and dance.',
        'imageAssetPath': 'assets/pillar3.png',
        'displayOrder': 3,
      },
    ];

    for (var pillar in pillars) {
      await _db.collection('pillars').add(pillar);
    }
    developer.log('Pillars seeded', name: 'FirestoreSeed');
  }

  /// Seeds the sponsors collection
  static Future<void> seedSponsors() async {
    final sponsors = [
      {
        'name': 'The City of Norfolk',
        'logoUrl': 'https://via.placeholder.com/200x100?text=Norfolk',
        'websiteUrl': 'https://www.norfolk.gov',
        'displayOrder': 1,
      },
      {
        'name': 'Norfolk Public Schools',
        'logoUrl': 'https://via.placeholder.com/200x100?text=NPS',
        'websiteUrl': 'https://www.nps.k12.va.us',
        'displayOrder': 2,
      },
      {
        'name': 'Norfolk Arts',
        'logoUrl': 'https://via.placeholder.com/200x100?text=Norfolk+Arts',
        'websiteUrl': '',
        'displayOrder': 3,
      },
      {
        'name': 'The Boys & Girls Club',
        'logoUrl': 'https://via.placeholder.com/200x100?text=BGC',
        'websiteUrl': 'https://www.bgca.org',
        'displayOrder': 4,
      },
      {
        'name': 'The Purpose Pusher',
        'logoUrl':
            'https://via.placeholder.com/200x100?text=Purpose+Pusher',
        'websiteUrl': '',
        'displayOrder': 5,
      },
      {
        'name': 'Shark City Sportswear',
        'logoUrl': 'https://via.placeholder.com/200x100?text=Sportswear',
        'websiteUrl': '',
        'displayOrder': 6,
      },
      {
        'name': 'The Heart of Giving',
        'logoUrl': 'https://via.placeholder.com/200x100?text=Heart+of+Giving',
        'websiteUrl': '',
        'displayOrder': 7,
      },
      {
        'name': 'Walmart',
        'logoUrl': 'https://via.placeholder.com/200x100?text=Walmart',
        'websiteUrl': 'https://www.walmart.com',
        'displayOrder': 8,
      },
      {
        'name': 'The Home Depot',
        'logoUrl': 'https://via.placeholder.com/200x100?text=Home+Depot',
        'websiteUrl': 'https://www.homedepot.com',
        'displayOrder': 9,
      },
      {
        'name': 'The Office of The Commonwealth Attorney',
        'logoUrl': 'https://via.placeholder.com/200x100?text=Attorney',
        'websiteUrl': '',
        'displayOrder': 10,
      },
    ];

    for (var sponsor in sponsors) {
      await _db.collection('sponsors').add(sponsor);
    }
    developer.log('Sponsors seeded', name: 'FirestoreSeed');
  }

  /// Seeds the gallery_items collection
  static Future<void> seedGalleryItems() async {
    final now = DateTime.now();
    final galleryItems = [
      {
        'type': 'photo',
        'url': 'https://via.placeholder.com/800x600?text=Drumline+Performance',
        'thumbnailUrl': '',
        'caption': 'Drumline at the 2024 Nationals',
        'category': 'Performances',
        'timestamp': Timestamp.fromDate(now.subtract(const Duration(days: 30))),
      },
      {
        'type': 'photo',
        'url': 'https://via.placeholder.com/800x600?text=Dance+Ensemble',
        'thumbnailUrl': '',
        'caption': 'Dance ensemble winter showcase',
        'category': 'Performances',
        'timestamp': Timestamp.fromDate(now.subtract(const Duration(days: 45))),
      },
      {
        'type': 'photo',
        'url': 'https://via.placeholder.com/800x600?text=Rehearsal',
        'thumbnailUrl': '',
        'caption': 'Saturday morning rehearsal',
        'category': 'Rehearsals',
        'timestamp': Timestamp.fromDate(now.subtract(const Duration(days: 7))),
      },
      {
        'type': 'photo',
        'url': 'https://via.placeholder.com/800x600?text=Competition',
        'thumbnailUrl': '',
        'caption': 'Regional competition trophy presentation',
        'category': 'Performances',
        'timestamp': Timestamp.fromDate(now.subtract(const Duration(days: 60))),
      },
      {
        'type': 'video',
        'url': 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        'thumbnailUrl':
            'https://via.placeholder.com/800x600?text=2024+Recap+Video',
        'caption': 'Watch our 2024 season recap!',
        'category': 'Performances',
        'timestamp': Timestamp.fromDate(now.subtract(const Duration(days: 90))),
      },
      {
        'type': 'photo',
        'url': 'https://via.placeholder.com/800x600?text=Community+Event',
        'thumbnailUrl': '',
        'caption': 'Community outreach performance',
        'category': 'Performances',
        'timestamp': Timestamp.fromDate(now.subtract(const Duration(days: 15))),
      },
    ];

    for (var item in galleryItems) {
      await _db.collection('gallery_items').add(item);
    }
    developer.log('Gallery items seeded', name: 'FirestoreSeed');
  }
}
