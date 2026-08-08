/* ==========================================================================
   MOCK DATA FOR MODULE 6: COMMUNICATION MODULE
   ========================================================================== */

const MOCK_NOTIFICATIONS = [
  { id:1, category:'internship', title:'New Internship Match', desc:'A new SDE Intern position at Google matches your profile. Apply before July 25.', time:'2 hours ago', read:false },
  { id:2, category:'interview', title:'Interview Scheduled', desc:'Your interview with Microsoft for PM Intern is confirmed for July 22 at 2:30 PM.', time:'5 hours ago', read:false },
  { id:3, category:'offer', title:'Offer Letter Received', desc:'Congratulations! Amazon has sent you an offer letter for SDE Intern position.', time:'1 day ago', read:false },
  { id:4, category:'certificate', title:'Certificate Ready', desc:'Your internship completion certificate from TCS is ready for download.', time:'2 days ago', read:true },
  { id:5, category:'system', title:'Profile Incomplete', desc:'Complete your profile to increase visibility to recruiters. Add your skills section.', time:'3 days ago', read:true },
  { id:6, category:'internship', title:'Application Viewed', desc:'Infosys has viewed your application for Systems Engineer trainee.', time:'3 days ago', read:true },
  { id:7, category:'interview', title:'Interview Reminder', desc:'Reminder: Your Google SWE Intern interview is tomorrow at 10:00 AM.', time:'4 days ago', read:true },
  { id:8, category:'system', title:'Resume Updated', desc:'Your resume "Aarav_Patel_Resume_v2.pdf" was successfully uploaded.', time:'5 days ago', read:true },
  { id:9, category:'offer', title:'Offer Deadline Approaching', desc:'The acceptance deadline for Amazon SDE Intern offer is July 25. Please respond.', time:'5 days ago', read:false },
  { id:10, category:'certificate', title:'Document Verified', desc:'Your Bonafide Certificate has been verified by the placement cell.', time:'1 week ago', read:true }
];

const MOCK_CHAT_CONTACTS = [
  { id:1, name:'Google HR', role:'Company', avatar:'G', color:'#ea4335', bg:'#fce8e6', status:'online', lastMsg:'Looking forward to your interview!', time:'10:30 AM', unread:true },
  { id:2, name:'Microsoft Recruiter', role:'Company', avatar:'M', color:'#00a4ef', bg:'#e5f6fd', status:'online', lastMsg:'Please confirm the interview slot.', time:'Yesterday', unread:true },
  { id:3, name:'SIMS Admin', role:'Admin', avatar:'SA', color:'#6366f1', bg:'#eef2ff', status:'online', lastMsg:'Your documents have been verified.', time:'Yesterday', unread:false },
  { id:4, name:'Amazon Team', role:'Company', avatar:'A', color:'#ff9900', bg:'#fff5e5', status:'offline', lastMsg:'Congratulations on your offer!', time:'Jul 15', unread:false },
  { id:5, name:'TCS Campus', role:'Company', avatar:'T', color:'#0f52ba', bg:'#e7eff8', status:'offline', lastMsg:'Thank you for attending the drive.', time:'Jul 12', unread:false },
  { id:6, name:'Placement Cell', role:'Admin', avatar:'PC', color:'#16a34a', bg:'#f0fdf4', status:'online', lastMsg:'Submit your NOC by Aug 5.', time:'Jul 10', unread:false }
];

const MOCK_CHAT_MESSAGES = {
  1: [
    { sender:'them', text:'Hi Aarav! Thank you for applying to the SWE Intern position at Google.', time:'9:00 AM', seen:true },
    { sender:'them', text:'Your interview has been scheduled for July 20 at 10:00 AM via Google Meet.', time:'9:01 AM', seen:true },
    { sender:'me', text:'Thank you! I have noted the schedule. Looking forward to it.', time:'9:15 AM', seen:true },
    { sender:'them', text:'Great! Please ensure you have a stable internet connection. Good luck! 🎉', time:'9:20 AM', seen:true },
    { sender:'me', text:'Absolutely. I will be prepared. Thank you for the opportunity!', time:'9:25 AM', seen:true },
    { sender:'them', text:'Looking forward to your interview!', time:'10:30 AM', seen:false }
  ],
  2: [
    { sender:'them', text:'Hello Aarav, we have a PM Intern interview slot available on July 22 at 2:30 PM. Can you confirm?', time:'Yesterday 3:00 PM', seen:true },
    { sender:'me', text:'Yes, I can confirm. I will be available.', time:'Yesterday 3:30 PM', seen:true },
    { sender:'them', text:'Please confirm the interview slot.', time:'Yesterday 4:00 PM', seen:false }
  ],
  3: [
    { sender:'them', text:'Hi Aarav, your submitted documents have been reviewed and verified by the admin team.', time:'Yesterday 11:00 AM', seen:true },
    { sender:'them', text:'Your documents have been verified.', time:'Yesterday 11:05 AM', seen:true }
  ]
};

const MOCK_FEEDBACK = [
  { id:1, company:'TCS', role:'System Analyst Trainee', stars:4, text:'Great learning experience. The mentors were supportive and the work culture was excellent. Would recommend to fellow students.', date:'10 Jul 2026', avatar:'AP' },
  { id:2, company:'Infosys', role:'Systems Engineer', stars:3, text:'Decent internship but limited hands-on coding. More theoretical sessions. Good campus and infrastructure.', date:'25 Jun 2026', avatar:'AP' }
];

const MOCK_FAQ = [
  { q:'How do I apply for an internship?', a:'Go to Browse Internships from the sidebar, select an internship that interests you, click "View Details", and then click "Apply Now". You will need to select a resume and write a cover letter.' },
  { q:'Can I reschedule my interview?', a:'Yes, go to Interview Schedule, find the interview card, and click "Reschedule". You will need to provide a reason and your preferred time slots. The company will review and confirm.' },
  { q:'How do I accept or reject an offer letter?', a:'Navigate to the Offer Letter page from the sidebar. Review the offer details and click "Accept Offer" or "Reject Offer". Accepted offers cannot be reversed.' },
  { q:'Where can I download my certificates?', a:'Go to Certificates & Documents in the Resume & Documents section. All your verified certificates are available for download there.' },
  { q:'How do I update my profile?', a:'Click on "My Profile" in the sidebar, then click the "Edit Profile" button. You can update your personal information, education, skills, and more.' },
  { q:'What should I do if I face a technical issue?', a:'Use the Help & Support page to raise a support ticket. Select "Technical Issue" as the category and describe the problem in detail. Our team typically responds within 24 hours.' },
  { q:'How does the placement process work?', a:'After applying to internships, shortlisted candidates are invited for interviews. Upon successful interviews, companies issue offer letters which you can accept or reject through the portal.' }
];
