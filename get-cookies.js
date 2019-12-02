class Cookies {
  constructor() {
    this.COOKIES = [];
    this.initializeCookies();
  }

  initializeCookies() {
    let cookiesEl = document
      .querySelector('settings-ui')
      .shadowRoot.querySelector('#main')
      .shadowRoot.querySelector('.showing-subpage')
      .shadowRoot.querySelector('settings-privacy-page')
      .shadowRoot.querySelector('site-data-details-subpage')
      .shadowRoot.querySelectorAll('iron-collapse');

    this.COOKIES = [];

    cookiesEl.forEach(cookieEl => {
      let cookieElText = cookieEl.innerText.split('\n');
      let cookieResult = {};

      for (let i = 0; i < cookieElText.length - 1; i += 2) {
        cookieElText.forEach((item, index) => {
          if (index % 2 === 0) {
            cookieResult[item] = cookieElText[index + 1];
          }
        });
      }

      this.COOKIES.push(cookieResult);
    });
  }

  getCookies() {
    const NEW_COOKIES = [];
    this.COOKIES.forEach(cookie => {
      let NEW_COOKIE = {};
      if (cookie.Name) {
        NEW_COOKIE.name = cookie.Name || '';
        NEW_COOKIE.value = cookie.Content || '';
        NEW_COOKIE.domain = cookie.Domain || '';
        NEW_COOKIE.expirationDate = cookie.Expires || '';
        NEW_COOKIE.path = cookie.Path || '';
        NEW_COOKIE.HTTP = true;
        NEW_COOKIE.secure =
          cookie['Send for'] === 'Secure connections only'
            ? true
            : false;

        NEW_COOKIES.push(NEW_COOKIE);
      }
    });
    return NEW_COOKIES;
  }
}

let cookies = new Cookies();

copy(cookies.getCookies());
