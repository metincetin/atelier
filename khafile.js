let project = new Project("atelier");
project.addAssets("Assets/**");
project.addShaders("Shaders/**");
project.addSources("src");
await project.addProject("Libraries/dreamengine")
resolve(project);
