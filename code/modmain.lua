Assets = {
	Asset("ATLAS", "images/mappin.xml"),
	Asset("IMAGE", "images/mappin.tex")
}

AddMinimapAtlas("images/mappin.xml")

local function MakePin()
	local inst = GLOBAL.CreateEntity()
	inst.entity:AddTransform()
	--inst.entity:AddAnimState()
	--inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon("mappin.tex")
	inst.MiniMapEntity:SetPriority(5)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	inst.MiniMapEntity:SetCanUseCache(false)
	inst.MiniMapEntity:SetEnabled(false)
	inst.entity:SetCanSleep(false)
	return inst
end

mappin1 = MakePin()
mappin2 = MakePin()
mappin1.MiniMapEntity:SetIsProxy(true)
mappin2.MiniMapEntity:SetIsProxy(false)

local function SetPin(x, y, z)
	mappin1.Transform:SetPosition(x, y, z)
	mappin2.Transform:SetPosition(x, y, z)
	mappin1.MiniMapEntity:SetEnabled(true)
	mappin2.MiniMapEntity:SetEnabled(true)
end

AddClassPostConstruct(
	"screens/mapscreen",
	function(self)
		local OnMouseButton_old = self.OnMouseButton
		self.OnMouseButton = function(self, button, down, x, y)
			if OnMouseButton_old then
				OnMouseButton_old(self, button, down, x, y)
			end
			if button == GLOBAL.MOUSEBUTTON_RIGHT and down then
				local topscreen = GLOBAL.TheFrontEnd:GetActiveScreen()
				if topscreen.minimap ~= nil then
					local mousepos = GLOBAL.TheInput:GetScreenPosition()
					local mousewidgetpos = topscreen:ScreenPosToWidgetPos(mousepos)
					local mousemappos = topscreen:WidgetPosToMapPos(mousewidgetpos)
					local x, y, z = topscreen.minimap:MapPosToWorldPos(mousemappos:Get())
					SetPin(x, 0, y)
					target_pos = GLOBAL.Vector3(x, 0, y)
					GLOBAL.ThePlayer.components.playercontroller:DoAction(
						GLOBAL.BufferedAction(GLOBAL.ThePlayer, nil, GLOBAL.ACTIONS.WALKTO, nil, GLOBAL.Vector3(x, 0, y))
					)
				end
			end
		end
	end
)
