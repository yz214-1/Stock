(function (jQuery) {
    "use strict";
    var	revapi4, revapi1,
        tpj;
    jQuery(function() {
        tpj = jQuery;
        if(tpj("#rev_slider_4_1").revolution == undefined){
            revslider_showDoubleJqueryError("#rev_slider_4_1");
        }else{
            revapi4 = tpj("#rev_slider_4_1").show().revolution({
                jsFileLocation:"js/",
                sliderLayout:"fullwidth",
                visibilityLevels:"1240,1024,778,480",
                gridwidth:"1400,1024,767,479",
                gridheight:"600,600,800,600",
                minHeight:"",
                autoHeight:true,
                lazyType:"smart",
                spinner:"spinner0",
                editorheight:"600,600,800,600",
                responsiveLevels:"1240,1024,778,480",
                disableProgressBar:"on",
                navigation: {
                    mouseScrollNavigation:false,
                    touch: {
                        touchenabled:true
                    }
                },
                parallax: {
                    levels:[1,2,3,4,5,30,35,40,45,46,47,48,49,50,51,55],
                    type:"mouse"
                },
                fallbacks: {
                    allowHTML5AutoPlayOnAndroid:true
                },
            });
        }


    });

    jQuery(function() {
        tpj = jQuery;
        if(tpj("#rev_slider_1_1").revolution == undefined){
            revslider_showDoubleJqueryError("#rev_slider_1_1");
        }else{
            revapi1 = tpj("#rev_slider_1_1").show().revolution({
                jsFileLocation:"js/",
                sliderLayout:"fullwidth",
                visibilityLevels:"1240,1240,1240,480",
                gridwidth:"1400,1400,1400,479",
                gridheight:"700,700,700,600",
                minHeight:"",
                autoHeight:true,
                lazyType:"smart",
                spinner:"spinner0",
                editorheight:"700,768,400,600",
                responsiveLevels:"1240,1240,1240,480",
                disableProgressBar:"on",
                navigation: {
                    mouseScrollNavigation:false,
                    touch: {
                        touchenabled:true
                    }
                },
                parallax: {
                    levels:[1,2,3,4,5,30,35,40,45,46,47,48,49,50,51,55],
                    type:"mouse"
                },
                fallbacks: {
                    allowHTML5AutoPlayOnAndroid:true
                },
            });
        }

    });
})(jQuery); 