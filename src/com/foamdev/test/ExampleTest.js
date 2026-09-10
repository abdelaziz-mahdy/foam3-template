foam.CLASS({
  package: 'com.foamdev.test',
  name: 'ExampleTest',
  extends: 'foam.core.test.Test',

  javaImports: [
    'com.foamdev.*',
    'foam.dao.DAO',
    'foam.lang.X',
    'foam.util.SafetyUtil'
  ],

  methods: [
    {
      name: 'runTest',
      javaCode: `
        var example = new Example();
        test ( SafetyUtil.isEmpty(example.getId()), "ID empty before create");
        example = (Example) ((DAO) x.get("exampleDAO")).put(example);
        test ( ! SafetyUtil.isEmpty(example.getId()), "ID set after create");
      `
    }
  ]
});
