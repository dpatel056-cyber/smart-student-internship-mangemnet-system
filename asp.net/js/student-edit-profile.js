(function(){
    var i = document.getElementById('FileUpload1'),
        p = document.getElementById('imgProfilePreview'),
        init = document.getElementById('lblProfileInitials');
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
            if (init) {
                init.style.display = 'none';
            }
        };
        r.readAsDataURL(f);
    });
}());
