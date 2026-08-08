/* =====================================================================
   INTERNSHIPS DATASET (generated from COMPANIES_DATA)
   Each internship: id, title, categoryKey, categoryLabel, company, companyIcon,
   location, locationKey, modeKey, modeLabel, stipendType ('paid'|'unpaid'),
   stipend, durationLabel, durationKey, postedDaysAgo
===================================================================== */

const INTERN_TITLE_POOLS = {
  "it-services": ["Software Engineering Intern", "QA & Testing Intern", "Cloud Support Intern", "IT Consulting Intern", "Business Analyst Intern"],
  "technology": ["Web Development Intern", "Software Engineering Intern", "Data Analytics Intern", "Product Management Intern", "UI/UX Design Intern"],
  "finance": ["Finance Intern", "Financial Analyst Intern", "Risk Management Intern", "Investment Research Intern", "Fintech Product Intern"],
  "marketing": ["Marketing Intern", "Digital Marketing Intern", "Content Marketing Intern", "SEO Intern", "Brand Strategy Intern"],
  "design": ["UI/UX Design Intern", "Graphic Design Intern", "Product Design Intern", "Frontend Engineering Intern"],
  "education": ["Curriculum Design Intern", "EdTech Product Intern", "Content Research Intern", "Academic Ops Intern"],
  "consulting": ["Business Analyst Intern", "Strategy Consulting Intern", "Research Analyst Intern", "Operations Intern"],
  "ecommerce": ["Supply Chain Intern", "Category Management Intern", "Growth Marketing Intern", "Product Analyst Intern"],
  "healthcare": ["Healthcare Analyst Intern", "Clinical Research Intern", "Operations Intern", "Product Intern"],
  "manufacturing": ["Mechanical Engineering Intern", "Production Planning Intern", "Quality Assurance Intern", "Supply Chain Intern"]
};

const INTERN_CATEGORY_MAP = [
  { test: /web|frontend/i, key: "software-dev", label: "Software Development" },
  { test: /software|cloud|qa|engineering(?! & Manufacturing)/i, key: "software-dev", label: "Software Development" },
  { test: /data/i, key: "data-science", label: "Data Science" },
  { test: /design/i, key: "design", label: "Design (UI/UX)" },
  { test: /marketing|seo|brand|growth/i, key: "marketing", label: "Marketing" },
  { test: /financial|finance|risk|investment|fintech/i, key: "finance", label: "Finance" },
  { test: /product/i, key: "product", label: "Product Management" },
  { test: /business|strategy|research|operations|consulting|category/i, key: "business", label: "Business & Consulting" },
  { test: /mechanical|production|quality|supply chain/i, key: "engineering", label: "Engineering & Manufacturing" },
  { test: /healthcare|clinical/i, key: "healthcare", label: "Healthcare" },
  { test: /curriculum|edtech|academic/i, key: "education", label: "Education" },
  { test: /it consulting/i, key: "business", label: "Business & Consulting" }
];

function categorizeInternTitle(title) {
  for (const rule of INTERN_CATEGORY_MAP) {
    if (rule.test.test(title)) return { key: rule.key, label: rule.label };
  }
  return { key: "business", label: "Business & Consulting" };
}

function internSeededRandom(seed) {
  let h = 0;
  for (let i = 0; i < seed.length; i++) { h = (h * 31 + seed.charCodeAt(i)) >>> 0; }
  return function () {
    h = (h * 1664525 + 1013904223) >>> 0;
    return (h & 0xfffffff) / 0xfffffff;
  };
}

const DURATION_BUCKETS = [
  { key: "1-month", label: "1 Month" },
  { key: "2-3-months", label: "2-3 Months" },
  { key: "3-6-months", label: "3-6 Months" },
  { key: "6-plus-months", label: "6+ Months" }
];

const MODE_OPTIONS = [
  { key: "wfh", label: "Work From Home" },
  { key: "hybrid", label: "Hybrid" },
  { key: "onsite", label: "On-site" }
];

function buildInternshipsData() {
  const list = [];

  const companies = Array.isArray(window.COMPANIES_DATA) ? window.COMPANIES_DATA : [];

  if (!companies.length) {
    return [];
  }

  companies.slice(0, 15).forEach((company, idx) => {
    const pool = INTERN_TITLE_POOLS[company.category] || INTERN_TITLE_POOLS.technology;
    const title = pool[idx % pool.length];
    const cat = categorizeInternTitle(title);
    const rand = internSeededRandom(company.name + "-internships");
    const isUnpaid = idx === 10;
    const stipend = isUnpaid ? 0 : (12000 + (idx * 1000));
    const mode = company.locationKey === 'remote'
      ? MODE_OPTIONS[0]
      : (idx % 3 === 0 ? MODE_OPTIONS[1] : idx % 3 === 1 ? MODE_OPTIONS[0] : MODE_OPTIONS[2]);
    const duration = DURATION_BUCKETS[idx % DURATION_BUCKETS.length];

    list.push({
      id: idx + 1,
      title,
      categoryKey: cat.key,
      categoryLabel: cat.label,
      company: company.name,
      companyIcon: company.icon,
      location: company.location,
      locationKey: company.locationKey,
      modeKey: mode.key,
      modeLabel: mode.label,
      stipendType: isUnpaid ? "unpaid" : "paid",
      stipend,
      durationLabel: duration.label,
      durationKey: duration.key,
      postedDaysAgo: idx + 1,
      vacancies: 2 + (idx % 4),
      description: `${company.name} is hiring a motivated ${title} to work on real projects and build practical experience.`,
      responsibilities: [
        `Support the ${title.toLowerCase()} team with day-to-day tasks.`,
        "Collaborate with mentors and teammates on assigned work.",
        "Learn tools, workflows, and company standards quickly.",
        "Deliver tasks on time and communicate progress clearly."
      ],
      benefits: [
        "Certificate",
        "Mentorship",
        idx % 2 === 0 ? "Flexible Hours" : "Real Projects",
        idx % 3 === 0 ? "Letter of Recommendation" : "Career Growth"
      ],
      skills: [
        { name: "Communication" },
        { name: idx % 2 === 0 ? "Problem Solving" : "Teamwork" },
        { name: idx % 3 === 0 ? "Adaptability" : "Time Management" }
      ],
      status: "Active",
      department: company.tag
    });
  });

  return list.slice(0, 15);
}

const DEFAULT_INTERNSHIPS_DATA = buildInternshipsData();

function readStoredInternships() {
  try {
    const raw = localStorage.getItem('SIMS_INTERNSHIPS_DATA');
    const parsed = raw ? JSON.parse(raw) : null;
    return Array.isArray(parsed) ? parsed : null;
  } catch {
    return null;
  }
}

const storedInternships = readStoredInternships();
window.INTERNSHIPS_DATA = storedInternships && storedInternships.length >= 15
  ? storedInternships
  : DEFAULT_INTERNSHIPS_DATA;

try {
  if (!storedInternships || storedInternships.length < 15) {
    localStorage.setItem('SIMS_INTERNSHIPS_DATA', JSON.stringify(window.INTERNSHIPS_DATA));
  }
} catch {
  // Ignore storage failures and keep the in-memory fallback data.
}

window.saveInternshipsData = function() {
  try {
    localStorage.setItem('SIMS_INTERNSHIPS_DATA', JSON.stringify(window.INTERNSHIPS_DATA));
    window.dispatchEvent(new Event('storage'));
  } catch {
    // Ignore storage failures and keep the in-memory copy.
  }
};
