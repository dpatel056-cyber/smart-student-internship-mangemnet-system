// SIMS - Company Post Internship Script
function toggleStipend(isPaid) {
                    var stipendField = document.getElementById('stipendAmountField');
                    if(stipendField) {
                        stipendField.style.display = isPaid ? 'block' : 'none';
                    }
                }
