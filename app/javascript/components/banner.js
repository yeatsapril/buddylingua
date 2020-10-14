import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Meet a buddy, learn a language.",
    "Møt en venn lær et språk.",
    "Rencontrez un copain, apprenez une langue.", 
    "Träffa en vän, lära sig ett språk.",
    "Incontrare un amico, imparare una lingua.",
    "Møde en ven, lære et sprog.",
    "Poznaj przyjaciela, naucz się języka.",
    "Einen Freund treffen, eine Sprache lernen.",     
    "Conocer a un amigo, aprender un idioma."],
    typeSpeed: 50,
    loop: true, 
    showCursor: false,
  });
}

export { loadDynamicBannerText };