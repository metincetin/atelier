let project = new Project('Atelier Windows');

project.addFile('src/**');
project.addIncludeDir('src');

resolve(project);