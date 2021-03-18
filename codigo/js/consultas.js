document.addEventListener('DOMContentLoaded', function () {
    var carouselElems = document.querySelector('.carousel.carousel-slider');
        var carouselInstance = M.Carousel.init(carouselElems, {
            fullWidth: true,
            indicators: true,
            numVisible:2
        });
    });
    function moveNextCarousel() {
        var elems = document.querySelector('.carousel.carousel-slider');
        var moveRight = M.Carousel.getInstance(elems);
        moveRight.next(1);
    }
    function movePrevCarousel() {
        var elems = document.querySelector('.carousel.carousel-slider');
        var moveLeft = M.Carousel.getInstance(elems);
        moveLeft.prev(1);
    }

    $(document).ready(function(){
        $('select').formSelect();
      });

M.AutoInit();

var listaProg = [];

function selCard(evt) {
    if(evt.currentTarget.className.includes("blue-grey")){
        evt.currentTarget.className = evt.currentTarget.className.replace(" blue-grey", " light-blue");
        listaProg.push(evt.currentTarget.id);
        console.table(listaProg);
    }
    else if(evt.currentTarget.className.includes("light-blue")){
        evt.currentTarget.className = evt.currentTarget.className.replace(" light-blue", " blue-grey");
        let pos = listaProg.indexOf(evt.currentTarget.id);
        listaProg.splice(pos, 1);
        console.table(listaProg);
    }
    if(listaProg.length > 1){
        document.getElementById('CalifOProg').removeAttribute("disabled");
    }else{
        document.getElementById('CalifOProg').setAttribute("disabled",null);
    }
}

function hacerConsulta(){
    console.log(document.getElementById('CalifOProg').checked);
    if(listaProg.length > 1){
        if(document.getElementById('CalifOProg').checked){
            location.replace("./consultasResultados1.html");
        }else{
            location.replace("./consultasResultados2.html");
        }
    }else{
        if(document.getElementById('datosPart').checked){
            location.replace("./consultasResultados3.html");
        }else{
            location.replace("./consultasResultados4.html");
        }
    }
}