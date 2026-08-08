/* =====================================================================
   COMPANIES DATASET
   Each company: name, tag (display industry text), category (filter key),
   location, locationKey (filter key), openings, size (filter key),
   founded (year), popularity (sort score), icon {type:'img', url}
===================================================================== */

const DEFAULT_COMPANIES_DATA = [
  { name:"Google", tag:"Technology, Internet", category:"technology", location:"Bengaluru, India", locationKey:"bengaluru", openings:12, size:"5000+", founded:1998, popularity:99, icon:{type:"img", url:"../assets/logo-google.png"} },
  { name:"Amazon", tag:"E-commerce, Cloud", category:"ecommerce", location:"Bengaluru, India", locationKey:"bengaluru", openings:20, size:"5000+", founded:1994, popularity:98, icon:{type:"img", url:"../assets/logo-amazon.png"} },
  { name:"Microsoft", tag:"Technology, Software", category:"technology", location:"Hyderabad, India", locationKey:"hyderabad", openings:8, size:"5000+", founded:1975, popularity:97, icon:{type:"img", url:"../assets/logo-microsoft.png"} },
  { name:"TCS", tag:"IT Services, Consulting", category:"it-services", location:"Mumbai, India", locationKey:"mumbai", openings:15, size:"5000+", founded:1968, popularity:95, icon:{type:"img", url:"../assets/logo-tcs.svg"} },
  { name:"Deloitte", tag:"Consulting, Business", category:"consulting", location:"Gurugram, India", locationKey:"gurugram", openings:10, size:"5000+", founded:1845, popularity:93, icon:{type:"img", url:"../assets/logo-deloitte.svg"} },
  { name:"Infosys", tag:"IT Services, Consulting", category:"it-services", location:"Pune, India", locationKey:"pune", openings:9, size:"5000+", founded:1981, popularity:92, icon:{type:"img", url:"../assets/logo-infosys.png"} },
  { name:"Wipro", tag:"IT Services, Consulting", category:"it-services", location:"Bengaluru, India", locationKey:"bengaluru", openings:7, size:"5000+", founded:1945, popularity:86, icon:{type:"img", url:"../assets/logo-wipro.svg"} },
  { name:"Flipkart", tag:"E-commerce, Retail", category:"ecommerce", location:"Bengaluru, India", locationKey:"bengaluru", openings:14, size:"5000+", founded:2007, popularity:90, icon:{type:"img", url:"../assets/logo-flipkart.svg"} },
  { name:"Zerodha", tag:"Finance, Fintech", category:"finance", location:"Bengaluru, India", locationKey:"bengaluru", openings:5, size:"201-1000", founded:2010, popularity:88, icon:{type:"img", url:"../assets/logo-zerodha.svg"} },
  { name:"Adobe", tag:"Design, Software", category:"design", location:"Noida, India", locationKey:"noida", openings:6, size:"1000-5000", founded:1982, popularity:90, icon:{type:"img", url:"../assets/logo-adobe.png"} },
  { name:"Paytm", tag:"Fintech, Payments", category:"finance", location:"Noida, India", locationKey:"noida", openings:8, size:"1000-5000", founded:2010, popularity:84, icon:{type:"img", url:"../assets/logo-paytm.png"} },
  { name:"Cognizant", tag:"IT Services, Consulting", category:"it-services", location:"Chennai, India", locationKey:"chennai", openings:11, size:"5000+", founded:1994, popularity:87, icon:{type:"img", url:"../assets/logo-cognizant.svg"} },
  { name:"LinkedIn", tag:"Technology, Internet", category:"technology", location:"Bengaluru, India", locationKey:"bengaluru", openings:4, size:"1000-5000", founded:2002, popularity:89, icon:{type:"img", url:"../assets/logo-linkedin.png"} },
  { name:"Accenture", tag:"IT Services, Consulting", category:"it-services", location:"Mumbai, India", locationKey:"mumbai", openings:14, size:"5000+", founded:1989, popularity:91, icon:{type:"img", url:"../assets/logo-accenture.svg"} },
  { name:"IBM", tag:"Technology, Cloud", category:"technology", location:"Bengaluru, India", locationKey:"bengaluru", openings:9, size:"5000+", founded:1911, popularity:85, icon:{type:"img", url:"../assets/logo-ibm.svg"} }
];

if (!localStorage.getItem('SIMS_COMPANIES_DATA')) {
    localStorage.setItem('SIMS_COMPANIES_DATA', JSON.stringify(DEFAULT_COMPANIES_DATA));
}
let storedCompanies = [];
try {
    storedCompanies = JSON.parse(localStorage.getItem('SIMS_COMPANIES_DATA')) || [];
} catch {
    storedCompanies = [];
}
window.COMPANIES_DATA = Array.isArray(storedCompanies) && storedCompanies.length >= 15 ? storedCompanies : DEFAULT_COMPANIES_DATA;
if (!Array.isArray(storedCompanies) || storedCompanies.length < 15) {
    localStorage.setItem('SIMS_COMPANIES_DATA', JSON.stringify(DEFAULT_COMPANIES_DATA));
}

window.saveCompaniesData = function() {
    localStorage.setItem('SIMS_COMPANIES_DATA', JSON.stringify(window.COMPANIES_DATA));
    window.dispatchEvent(new Event('storage'));
};
