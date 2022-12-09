include("shared.lua")

-- Draw some 3D text
local function Draw3DText( pos, ang, scale, text, flipView )
	if ( flipView ) then
		-- Flip the angle 180 degrees around the UP axis
		// ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
        ang.y = LocalPlayer():EyeAngles().y - 90 -- make it act like a sprite and look at the player
	end

	cam.Start3D2D( pos, ang, 0.6 )
		-- Actually draw the text. Customize this to your liking.
		draw.DrawText( text, "Default", 0, 0, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
    
    self:DrawModel()
    -- The text to display
	local text = "Jailer Panel"

	-- The position. We use model bounds to make the text appear just above the model. Customize this to your liking.
	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 20 )

	-- The angle
	local ang = Angle( 0, SysTime() * 0% 360, 90 )

	-- Draw front
	Draw3DText( pos, ang, 0.2, text, true )
	-- DrawDraw3DTextback
	Draw3DText( pos, ang, 0.2, text, true )
    
    
end



net.Receive("jailerpanel_open", function()
    local ply = LocalPlayer()
    local sizeW, sizeH, time, delay, ease = ScrW() * 0.2, ScrH() * 0.2, 1.8, 0, 0.1 
    local Frame = vgui.Create("DFrame")
    Frame:SetSize( 0, 0)
    Frame:Center()
    Frame:SetTitle( "" )
    Frame:SetVisible( true )
    Frame:SetDraggable( false )
    Frame:ShowCloseButton( true )
    Frame:MakePopup()
    Frame:GetPaintShadow(true)
    local isAnimating = true
    Frame:SizeTo(sizeW, sizeH, time, delay, ease, function()
        isAnimating = false
    end)
    Frame.Think = function(me)
        if isAnimating then
            me:Center()
        end
    end
    Frame.Paint = function(self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 123, 0, 0, 255 ) )
        draw.RoundedBox(0, 0, 0, sizeW, 30, Color( 32, 32, 32, 255 ))
    --NumSlide--   
    end
    local DermaNumSlider = vgui.Create( "DNumSlider", Frame )
    DermaNumSlider:SetPos( 80, 20 )				-- Set the position
    DermaNumSlider:SetSize( 300, 100 )			-- Set the size
    DermaNumSlider:SetText( "" )	-- Set the text above the slider
    DermaNumSlider:SetMin(0)				 	-- Set the minimum number you can slide to
    DermaNumSlider:SetMax(30)				-- Set the maximum number you can slide to
    DermaNumSlider:SetDecimals( 0 )	-- Decimal places - zero for whole number
    --Arrest Time Label--
    local DLabel = vgui.Create("DLabel", Frame)
    DLabel:SetSize(200,30)
    DLabel:SetPos(20,55)
    DLabel:SetText("Arrest Time (Minutes):")  
    DLabel:SetFontInternal("HudHintTextLarge")  
    --Reason ComboBox--
    local DComboBox = vgui.Create( "DComboBox", Frame )
    DComboBox:SetPos( 0, 100 )
    DComboBox:SetSize( sizeW, 50 )
    DComboBox:SetValue( "Arrest Reason" ) 
    DComboBox:SetFontInternal("HudHintTextLarge")  
    DComboBox:SetTextColor( Color(255,255,255) )
    DComboBox:AddChoice( "Equipment Abuse" )
    DComboBox:AddChoice( "Rape" )
    DComboBox:AddChoice( "Warcrimes" )
    DComboBox:AddChoice( "Other", -1 )
    DComboBox.Paint = function(self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 32, 32, 32, 255 ) )
    end
    function DComboBox:OnSelect(index, value, data)

        if(data == -1) then	
            DComboBox:Hide()
            
	    local TextEntry = vgui.Create( "DTextEntry", Frame ) -- create the form as a child of frame
	    TextEntry:SetPos( 0, 100 )
        TextEntry:SetSize( sizeW, 50 )
	    TextEntry.OnEnter = function( self )
		    chat.AddText( self:GetValue() )	-- print the textentry text as a chat message
        end

        end
    end
    --Arrest Button--
    local Button = vgui.Create("DButton", Frame)
    Button:SetText( "Arrest" )
    Button:SetFontInternal("HudHintTextLarge")  
    Button:SetTextColor( Color(255,255,255) )
    Button:SetSize( 200, 50  )
    Button:SetPos( 100, 160 )
    Button.Paint = function(self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 32, 32, 32, 255 ) )
    end
    Button.DoClick = function()
        
        net.Start("ArrestButton_Press")
        net.WriteEntity( ply )
        net.WriteInt( DermaNumSlider:GetValue(), 32 )    
        net.SendToServer()
        print("button works")
        
        
    end
end)