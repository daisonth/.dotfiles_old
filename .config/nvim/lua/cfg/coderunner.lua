require("code_runner").setup({
	mode = "float",
	-- put here the commands by filetype
	filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		typescript = "deno run",
		rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
		cpp = "cd $dir && g++ $fileName && ./a.out",
	},
})
