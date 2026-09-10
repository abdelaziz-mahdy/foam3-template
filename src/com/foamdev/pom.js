foam.POM({
  name: 'example',
  projects: [
    { name: 'test/pom',                 flags: 'test' }
  ],
  files: [
    { name: 'Example',                  flags: 'js|java' },
    { name: 'ExampleCategory',          flags: 'js|java' }
  ]
});
