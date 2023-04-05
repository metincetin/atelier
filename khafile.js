let project = new Project("atelier");
project.addAssets("Assets/**");
project.addShaders("Shaders/**");
project.addSources("src");
project.addLibrary("asys")
await project.addProject("Libraries/dreamengine")
resolve(project);
