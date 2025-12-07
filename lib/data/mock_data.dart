import '../models/workshop.dart';

// --- MOCK DATA ---

final List<Workshop> availableWorkshops = [
  Workshop(
    id: '1',
    title: 'Handcrafted Jewelry: Wire Wrapping Workshop',
    description:
        'Learn the basics of wire wrapping to create stunning jewelry pieces.',
    fullDescription:
        'Join Zein for a comprehensive wire-wrapping workshop where you\'ll learn techniques to create unique pendants and earrings.',
    imageUrl: 'https://placehold.co/400x300/F0F0F0/240046/white?text=Jewelry',
    category: 'Jewelry',
    location: 'Amman, Jordan',
    address: 'Swefieh Village, Second Floor',
    date: 'Thursday, Jan 15, 2026',
    time:
        '3 hours', // Duration for the card, actual duration is in 'duration' field
    rating: 4.9,
    instructor: 'Zein',
    instructorBio:
        'Zein is an expert jeweler with over 15 years of experience, known for her intricate wire-wrapped designs.',
    contactEmail: 'www.zeinjewelry.com',
    contactPhone: '+962 79 0444 024',
    price: 65.00,
    duration: '3 hours',
    level: 'Beginner',
    whatYoullLearn: [
      'Basic wire manipulation and shaping',
      'Creating loops and coils',
      'Setting cabochons or beads with wire',
    ],
    schedule: [
      WorkshopSchedule(
        title: 'Session 1: Introduction (30 min)',
        activities: ['Wire types and gauges', 'Tool usage demo'],
      ),
      WorkshopSchedule(
        title: 'Session 2: Practice (1 hour)',
        activities: ['Basic wraps', 'Forming pendants'],
      ),
      WorkshopSchedule(
        title: 'Session 3: Project (1.5 hours)',
        activities: ['Complete a wire-wrapped piece'],
      ),
    ],
    materials: ['Copper wire kit', 'Pliers set', 'Selection of beads'],
    spotsAvailable: 4,
    totalSpots: 12,
  ),
  Workshop(
    id: '2',
    title: 'Flower Arrangement Workshop',
    description:
        'Learn the art of flower arrangement and create beautiful bouquets.',
    fullDescription:
        'Join Amina to explore floral design principles and hands-on bouquet creation using seasonal flowers.',
    imageUrl:
        'https://placehold.co/400x300/F0F0F0/3C0046/white?text=Floral+Design',
    category: 'Floral Design',
    location: 'Artisan',
    address: 'Al-DAMMAM St., Amman, Jordan',
    date: 'Monday, Dec 28, 2026',
    time: '2.5 hours',
    rating: 4.7,
    instructor: 'Amina Khoury',
    instructorBio:
        'Amina is a skilled florist with a passion for creating stunning floral arrangements and teaching others the art of flower design.',
    contactEmail: 'amina.floral@example.com',
    contactPhone: '+962 78 444 5566',
    price: 40.00,
    duration: '2.5 hours',
    level: 'Beginner',
    whatYoullLearn: [
      'Basics of flower arrangement',
      'Choosing seasonal flowers',
      'Creating balanced bouquets',
      'Care and maintenance of arrangements',
    ],
    schedule: [
      WorkshopSchedule(
        title: 'Part 1: Fundamentals (1 hour)',
        activities: ['Flower types and care', 'Arrangement principles'],
      ),
      WorkshopSchedule(
        title: 'Part 2: Project Work (1.5 hours)',
        activities: [
          'Designing and creating your own bouquet',
          'Finishing touches and care tips',
          'Photography session of arrangements',
        ],
      ),
    ],
    materials: ['Seasonal flowers', 'Floral foam', 'Vases'],
    spotsAvailable: 8,
    totalSpots: 15,
  ),
  Workshop(
    id: '3',
    title: 'Candle Making Basics',
    description:
        'Create your own scented candles using various techniques and molds.',
    fullDescription:
        'Discover the art of candle making with Sara, learning to craft beautiful and aromatic candles for your home or as gifts.',
    imageUrl:
        'https://placehold.co/400x300/F0F0F0/460046/white?text=Candle+Making',
    category: 'Candle Making',
    location: 'Mamasima Studio',
    address: 'Swefieh Village, -1st Floor',
    date: 'Saturday, Feb 3, 2026',
    time: '3 hours',
    rating: 4.8,
    instructor: 'Ayah Hafez',
    instructorBio:
        'Ayah is an experienced candle maker who specializes in creating unique scents and decorative candles.',
    contactEmail: 'ayah.candles@example.com',
    contactPhone: '+962 79 089 8602',
    price: 55.00,
    duration: '3 hours',
    level: 'All Levels',
    whatYoullLearn: [
      'Understanding candle wax types',
      'Scent blending techniques',
      'Molding and decorating candles',
      'Safety and finishing tips',
    ],
    schedule: [
      WorkshopSchedule(
        title: 'Intro to Candle Making (45 min)',
        activities: ['Candle types', 'Wax types', 'Tools overview'],
      ),
      WorkshopSchedule(
        title: 'Technique Demos (1 hour)',
        activities: ['Scent blending', 'Molding', 'Decorating techniques'],
      ),
      WorkshopSchedule(
        title: 'Hands-on Creation (1.25 hours)',
        activities: ['Create 2-3 unique candles'],
      ),
    ],
    materials: ['Wax', 'Wicks', 'Fragrance oils', 'Molds'],
    spotsAvailable: 6,
    totalSpots: 10,
  ),
  Workshop(
    id: '4',
    title: 'Hand-building Pottery: Mugs',
    description:
        'Craft unique ceramic mugs using slab and coil techniques without a wheel.',
    fullDescription:
        'Learn foundational hand-building techniques to create functional ceramic mugs. No prior experience with pottery is needed, perfect for beginners.',
    imageUrl: 'https://placehold.co/400x300/F0F0F0/4C0046/white?text=Pottery',
    category: 'Pottery',
    location: 'My Pottery Shop',
    address: 'Mohammed Dawood Suliman St.no.8, Amman, Jordan',
    date: 'Sunday, Jan 23, 2026',
    time: '2 hours',
    rating: 4.6,
    instructor: 'Laila Hammad',
    instructorBio:
        'Laila is a passionate potter and sculptor who loves introducing people to the meditative art of working with clay.',
    contactEmail: 'laila.clay@example.com',
    contactPhone: '+962 79 555 6677',
    price: 25.00,
    duration: '2 hours',
    level: 'Beginner',
    whatYoullLearn: [
      'Preparing clay for hand-building',
      'Slab construction for mug body',
      'Coil building for handles',
      'Basic decorating and texturing',
    ],
    schedule: [
      WorkshopSchedule(
        title: 'Clay Prep & Basics (30 min)',
        activities: ['Kneading and rolling slabs', 'Introduction to tools'],
      ),
      WorkshopSchedule(
        title: 'Mug Construction (1 hour)',
        activities: ['Forming mug body', 'Attaching handle'],
      ),
      WorkshopSchedule(
        title: 'Finishing Touches (30 min)',
        activities: ['Smoothing, decorating, and preparing for firing'],
      ),
    ],
    materials: [
      'Clay',
      'Hand-building tools',
      'Glaze options',
      'Firing service',
    ],
    spotsAvailable: 5,
    totalSpots: 8,
  ),

  Workshop(
    id: '5',
    title: 'Perfume Workshop: Create Your Signature Scent',
    description:
        'Craft personalized perfumes using essential oils and fragrance blending techniques.',
    fullDescription:
        'Join Hana in a hands-on perfume-making workshop where you\'ll learn to blend scents and create your own unique fragrance.',
    imageUrl: 'https://placehold.co/400x300/F0F0F0/4C0046/white?text=Pottery',
    category: 'Scent Design',
    location: 'Etter Perfumery',
    address: 'Mohammed Dawood Suliman St.no.8, Amman, Jordan',
    date: 'Saturday, Dec 27, 2025',
    time: '3 hours',
    rating: 4.8,
    instructor: 'Muhannad Alattar',
    instructorBio:
        'Muhannad is an expert perfumer with a passion for teaching the art of fragrance creation.',
    contactEmail: 'muhannad.alattar@example.com',
    contactPhone: '+962 79 555 6677',
    price: 25.00,
    duration: '3 hours',
    level: 'Beginner',
    whatYoullLearn: [
      'Understanding fragrance notes',
      'Blending essential oils',
      'Creating balanced scent profiles',
      'Bottling and labeling your perfume',
    ],
    schedule: [
      WorkshopSchedule(
        title: 'Fragrance Notes & Basics (30 min)',
        activities: [
          'Understanding top, middle, and base notes',
          'Introduction to essential oils',
        ],
      ),
      WorkshopSchedule(
        title: 'Blending Techniques (1.5 hours)',
        activities: ['Mixing oils', 'Creating balanced scent profiles'],
      ),
      WorkshopSchedule(
        title: 'Finishing Touches (30 min)',
        activities: ['Sampling, bottling, and labeling your perfume'],
      ),
    ],
    materials: ['Essential oils', 'Blending tools', 'Bottles', 'Labels'],
    spotsAvailable: 3,
    totalSpots: 15,
  ),
];

// List of categories
final List<String> categories = [
  'All',
  'Jewelry',
  'Knitting',
  'Pottery',
  'Painting',
  'Drawing',
  'Sculpture',
];
