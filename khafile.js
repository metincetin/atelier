let project = new Project("atelier");
project.addAssets("Assets/**");
project.addShaders("Shaders/**");
project.addSources("src");
project.addParameter('--macro include("dreamengine.plugins.dreamui")');
await project.addProject("Libraries/dreamengine")
resolve(project);
