/* =========================================================
   MOCK DATA FOR MODULE 5: INTERVIEW & PLACEMENT MANAGEMENT
========================================================= */

const MOCK_INTERVIEWS = [
  {
    id: 1,
    company: "Google",
    role: "Software Engineering Intern",
    date: "2026-07-20",
    time: "10:00 AM",
    mode: "Online",
    location: "Google Meet",
    link: "https://meet.google.com/abc-defg-hij",
    interviewer: "Sundar P.",
    status: "scheduled",
    icon: { type: 'fa', value: 'fa-google', color: '#ea4335', bg: '#fce8e6' }
  },
  {
    id: 2,
    company: "Microsoft",
    role: "Product Management Intern",
    date: "2026-07-22",
    time: "02:30 PM",
    mode: "Online",
    location: "Microsoft Teams",
    link: "https://teams.microsoft.com/l/meetup-join/...",
    interviewer: "Satya N.",
    status: "pending", // Waiting for student confirmation
    icon: { type: 'fa', value: 'fa-microsoft', color: '#00a4ef', bg: '#e5f6fd' }
  },
  {
    id: 3,
    company: "TCS",
    role: "System Analyst Trainee",
    date: "2026-07-25",
    time: "09:00 AM",
    mode: "Offline",
    location: "TCS Garima Park, Gandhinagar",
    link: "",
    interviewer: "HR Team",
    status: "scheduled",
    icon: { type: 'text', value: 'TCS', color: '#0f52ba', bg: '#e7eff8' }
  },
  {
    id: 4,
    company: "Amazon",
    role: "SDE Intern",
    date: "2026-07-10",
    time: "11:00 AM",
    mode: "Online",
    location: "Amazon Chime",
    link: "",
    interviewer: "Tech Panel",
    status: "completed",
    icon: { type: 'fa', value: 'fa-amazon', color: '#ff9900', bg: '#fff5e5' }
  }
];

const MOCK_OFFERS = [
  {
    id: 101,
    company: "Amazon",
    studentName: "Aarav Patel",
    position: "Software Development Engineer (SDE) Intern",
    stipend: "₹85,000 / month",
    duration: "6 Months",
    joiningDate: "15 August 2026",
    deadlineDate: "2026-07-25",
    status: "pending", // pending, accepted, rejected
    icon: { type: 'fa', value: 'fa-amazon', color: '#ff9900', bg: '#fff5e5' },
    content: `We are thrilled to offer you the position of Software Development Engineer (SDE) Intern at Amazon. Your skills and background stood out during the interview process, and we are confident that you will make a valuable contribution to our team.

Your internship will commence on 15 August 2026 and will last for a duration of 6 Months. You will be compensated with a monthly stipend of ₹85,000.

Please review the attached terms and conditions. To accept this offer, please sign and submit this document before the acceptance deadline.`
  }
];

const MOCK_DEADLINES = [
  {
    id: 201,
    date: "2026-07-20",
    title: "Google Technical Interview",
    desc: "First round technical interview for SWE Intern.",
    type: "interview", // interview, deadline, offer
    priority: "high"
  },
  {
    id: 202,
    date: "2026-07-22",
    title: "Microsoft PM Interview",
    desc: "Product case study round.",
    type: "interview",
    priority: "high"
  },
  {
    id: 203,
    date: "2026-07-25",
    title: "Amazon Offer Acceptance",
    desc: "Last day to accept the SDE Intern offer letter.",
    type: "offer",
    priority: "high"
  },
  {
    id: 204,
    date: "2026-07-30",
    title: "Infosys Application Deadline",
    desc: "Last date to apply for the Systems Engineer role.",
    type: "deadline",
    priority: "medium"
  },
  {
    id: 205,
    date: "2026-08-05",
    title: "Document Submission",
    desc: "Submit NOC and Bonafide certificates to the college placement cell.",
    type: "deadline",
    priority: "low"
  }
];
