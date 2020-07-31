module.exports = {
    title: 'checkout-sdk-ruby',
    tagline: 'Checkout.com SDK for Ruby',
    url: 'https://stephen-gilbert-cko.github.io',
    baseUrl: '/checkout-sdk-ruby/',
    favicon: 'img/favicon.png',
    organizationName: 'stephen-gilbert-cko', // Usually your GitHub org/user name.
    projectName: 'checkout-sdk-ruby', // Usually your repo name.
    themeConfig: {
        prism: {
            additionalLanguages: ['ruby', 'bash'],
        },
        navbar: {
            title: 'checkout-sdk-ruby',
            logo: {
                alt: 'checkout-sdk-ruby',
                src: 'img/logo.png',
            },
            items: [
                {
                    to: 'getting_started',
                    activeBasePath: 'docs',
                    label: 'Docs',
                    position: 'right',
                },
                {
                    href: 'https://github.com/checkout/checkout-sdk-ruby',
                    label: 'GitHub',
                    position: 'right',
                },
            ],
        },
        footer: {
            style: 'dark',
            copyright: `© ${new Date().getFullYear()} Checkout.com    `,
        },
        googleAnalytics: {
            trackingID: 'UA-165971486-1',
        },
    },
    presets: [
        [
            '@docusaurus/preset-classic',
            {
                docs: {
                    sidebarPath: require.resolve('./sidebars.js'),
                    routeBasePath: '/',
                    // editUrl: 'https://github.com/facebook/docusaurus/edit/master/website/'
                },
                theme: {
                    customCss: require.resolve('./src/css/custom.css'),
                },
            },
        ],
    ],
    plugins: [
        // Basic usage.
        // require.resolve('@docusaurus/plugin-google-analytics'),
    ],
};
