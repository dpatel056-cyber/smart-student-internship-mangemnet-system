// SIMS - Company Edit Profile Script
(function(){
    var i = document.querySelector('[id$="FileUpload1"]') || document.querySelector('[id$="fileProfilePhoto"]'),
        p = document.querySelector('[id$="imgProfilePreview"]');
    if(!i) return;
    i.addEventListener('change', function(){
        var f = this.files && this.files[0];
        if(!f || !/^image\//i.test(f.type)) return;
        var r = new FileReader();
        r.onload = function(e){
            if (p) {
                p.src = e.target.result;
                p.style.display = 'block';
            }
        };
        r.readAsDataURL(f);
    });
}());
