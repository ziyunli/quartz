---
title: Playwright vs Cypress
date: 2023-07-05
tags:
  - Blogmarks
---

From https://old.reddit.com/r/QualityAssurance/comments/srhafv/cypress_vs_playwright/

> Playwright uses the *Chrome DevTools Protocol (CDP)* which allows automation directly in the browser and is supported by all the modern ones. This means, it doesn't run in the execution loop of the browser and as such needs an external process (Node, ...) to drive it. It's a bit like Selenium, which by default uses its own protocol+implementation to drive the browser (the web-drivers). Note that from the version 4,Selenium can now use the *CDP* protocol and its features.
>
> Cypress is an Electron App (Native JS app on desktop) which embeds the browser window in it. The library and your code are directly injected in the execution loop of the browser and needs to modify its default behavior to achieve this. It uses its own implementation for this purpose although a smoother integration with *CDP* is in progress, but it's not exposed via its API. Node is also used, but the main part of the control is delegated to the custom injected library (in the same process, I guess). PW (as Puppeteer) delegates this control to the *CDP* implementation of the browser, which is standardized and maintained by the browser providers.
>
> What are some consequences coming from these differences?
>
> - Cypress is limited to JavaScript and transpiled languages as it runs in the browser. Playwright is language independent and gets by default JS/TS, Python, C# and Java support. But you can easily use it with other frameworks/languages like RobotFramework for instance.
> - Cypress needs some adaptation for each type of browser, and currently Safari is not supported. Playwright is supported on all the modern browsers and even gets experimental support for native mobile testing.
> - CP doesn't support tabs. PW does.
> - Support of iframes is possible with CP but has sometimes an erratic behavior and is harder to use than with PW in our experience.
> - As it runs directly in the browser, you can set up [some shortcuts in your test/fixtures](https://www.cypress.io/blog/2019/01/03/stop-using-page-objects-and-start-using-app-actions/) for more efficiency with CP. It means that you can also implement Component/Unit tests with it, and it's [a promising feature](https://www.cypress.io/blog/2021/04/06/introducing-the-cypress-component-test-runner/). PW is focused on E2E/System tests, and you need another framework to handle the Unit/Component testing part (Jest, Karma/Jasmine ...). You have the choice to use a single framework or 2 different with CP. On the opposite, your tests are more close to the real end user's experience with PW as with CP which modifies the browser's behavior.
> - Although the integration with some high level (Acceptance/BDD) frameworks is possible, it's not as easy and more limited than with PW. For instance, when we integrate CP with CucumberJS the test runner is provided by CP and the structure of your scenarios and your implemented steps is more constraining. PW not only offers an integration with [CucumberJS](https://ediblecode.com/blog/playwright-cucumber-js/), [RobotFramework](https://rpaframework.org/libraries/browser_playwright/), [Gauge](https://spectrum.chat/gauge/general/gauge-test-runner-with-playwright-npm-package~7f961965-14d8-402b-a09e-c62c31ff3824), but [CodeceptJS](https://codecept.io/playwright/) provides also an official and excellent support for it and CP is not on their roadmap.
> - On the CI aspect. If you don't master the building agents configuration, you probably need a containerization solution (Docker) to deploy it. We just need *npm install* for PW.
> - Another point is about test parallelization. PW does provide it out of the box for free. CP doesn't. You'll have to subscribe to their SaaS offer to run your tests in parallel, or find [some workarounds](https://github.com/sorry-cypress/sorry-cypress) which are not perfect.
> - Remote browsing concern: Playwright is compliant with an internal/self-hosted Selenium grid ([https://playwright.dev/docs/selenium-grid](https://playwright.dev/docs/selenium-grid)). Both are supported on SaaS solutions (BrowserStack, ...)
> - On the UI/API aspect, they are relatively close. Both provide a runner, API mocking and fixtures, advanced locators, .... PW uses a classical pattern to manage asynchronicity (async/await) and CP has chosen a kind of *promise* answer (dot notation, which is in definitive not totally async) to simplify the code with autocompletion. To structure and reuse your code, CP also has a different approach with [custom commands](https://docs.cypress.io/api/cypress-api/custom-commands) to extend the *cy* keyword which is somewhat similar to the user centric approach of [TestingLibrary](https://testing-library.com/) or Codecept (the *I* prefix).
