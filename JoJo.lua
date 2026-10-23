	lastFruitTick = tick()
	x.RenderStepped:Connect(function()
		if getgenv().__BF_TELEPORTING then
			return
		end
		pcall(function()
			sethiddenproperty(t, "SimulationRadius", 5000)
		end)
		if tick() - lastHopTick >= 500 then
			lastHopTick = tick()
			pcall(function()
				writefile("Banana Cat Hub/Jobid.json", HttpService:JSONEncode({}))
			end)
		end
		pcall(function()
			if Settings["Auto Aimbot"] then
				local T = (function() if Settings["Select Method Aimbot"] == "Select Player" then return workspace.Characters[Settings["Select Player PVP"]] else return (ClosestPartaimbot()) end end)()
				if T and (T:FindFirstChild("HumanoidRootPart")) then
					local b = workspace.CurrentCamera
					G.Hit = T.HumanoidRootPart.CFrame
					G.Target = T
					getgenv().AimPos = CFrame.new(
						T.HumanoidRootPart.Position,
						T.HumanoidRootPart.Position + T.HumanoidRootPart.Velocity / 0.5
					)
				end
			end
			local T = t.Character:FindFirstChild("HumanoidRootPart")
			if T and (T:FindFirstChild("FloatForce")) and not TweenManager.currentTween then
				if not ToggleNoclip() or tick() - k.LastCall > 2 then
					TweenManager.CancelCurrent()
				end
			end
			if ToggleNoclip() or Settings.Noclip then
				local T, b, a = next, t.Character:GetDescendants()
				for s, s in T, b, a do
					if (s:IsA("MeshPart") or (s:IsA("Part"))) and s.CanCollide then
						s.CanCollide = false
					end
				end
			end
		end)
		task.spawn(function()
			if Settings["Change WalkSpeed"] then
				t.Character.Humanoid.WalkSpeed = Settings["Input WalkSpeed"] or 16
			end
			if Settings["Change JumpPower"] then
				t.Character.Humanoid.JumpPower = Settings["Input JumpPower"] or 50
			end
		end)
		if tick() - lastFruitTick >= 0.5 then
			lastFruitTick = tick()
			local T, T = pcall(function()
				if Settings["Random Devil Fruit"] then
					if getgenv().DebugGacha then
						local sw = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow")
						print("[Gacha] vòng lặp: toggle bật, SpinnerWindow =", sw ~= nil, sw and sw.Enabled)
					end
					if
						not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow")
						or not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow").Enabled
					then
						RandomFruit()
					elseif
						game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow").Enabled
						and game:GetService("Players").LocalPlayer.PlayerGui.SpinnerWindow.AboveSpinner.Navigation.CloseButton.Visible
					then
						Spinner:Close()
					end
				end
				if Settings["Auto Trade Bone"] then
					L.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
				end
				if Settings["Buy Blox Fruit Sniper Shop"] then
					BuyFruitShop()
				end
				if Settings["Auto Store Fruit"] then
					StoreFruit(t.Backpack)
					StoreFruit(t.Character)
				end
				if Settings["Auto Awake Fruit"] then
					L.Remotes.CommF_:InvokeServer("Awakener", "Check")
					L.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
				end
				if Settings["Auto Buy Legendary Sword"] then
					L.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
					if Settings["Hop Server [ Haki color or Legendary Sword]"] and CheckSwordLegendary then
						local b = CheckSwordLegendary()
						if b then
							SpecialHop(b)
						else
							A.CreateNoti({ Title = "NoiJo Hub", Desc = "Full Sword Legendary", ShowTime = 5 })
						end
					end
				end
				if Settings["Auto Buy Haki Color"] then
					L.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
					if Settings["Hop Server [ Haki color or Legendary Sword]"] then
						HopServer()
					end
				end
			end)
			if T then
				print(T)
			end
		end
	end)
end
-- (da bo collectgarbage("collect") luc OnTeleport: full GC giua luc engine dang huy map cu gay crash)
getgenv().__BF_LOADED = game.JobId
