package vshaxe.display;

class DisplayArgumentsSelector {
	static final statusBarWarningThemeColor = new ThemeColor("errorForeground");

	var displayArguments:DisplayArguments;
	var statusBarItem:StatusBarItem;

	public function new(context:ExtensionContext, displayArguments:DisplayArguments) {
		this.displayArguments = displayArguments;

		statusBarItem = window.createStatusBarItem(Left, 11);
		statusBarItem.tooltip = "Select Haxe Completion Provider";
		statusBarItem.command = cast SelectDisplayArgumentsProvider;
		context.subscriptions.push(statusBarItem);

		context.registerHaxeCommand(SelectDisplayArgumentsProvider, selectProvider);

		displayArguments.onDidChangeCurrentProvider(_ -> updateStatusBarItem());
		updateStatusBarItem();
	}

	function selectProvider() {
		var items:Array<QuickPickItem> = [
			for (name => provider in displayArguments.providers)
				{
					label: name,
					description: provider.description
				}
		];

		if (items.length == 0) {
			window.showErrorMessage("No Haxe completion providers registered.");
			return;
		}

		items.moveToStart(item -> item.label == displayArguments.currentProvider);
		window.showQuickPick(items, {placeHolder: "Select Haxe Completion Provider"})
			.then(item -> if (item != null) displayArguments.selectProvider(item.label));
	}

	function updateStatusBarItem() {
		if (displayArguments.currentProvider == null) {
			statusBarItem.hide();
			return;
		}

		var label = displayArguments.currentProvider;
		var color:Null<ThemeColor> = null;
		if (!displayArguments.isProviderRegistered(displayArguments.currentProvider)) {
			label = label + " (not available)"; // selected but not (yet?) loaded
			color = statusBarWarningThemeColor;
		}

		statusBarItem.color = color;
		statusBarItem.text = '$(gear) $label';
		statusBarItem.show();
	}
}
