package hot.prospects

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.MoreVert
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color

@Composable
fun ColorChangeContextMenu() {
    var backgroundColor by remember { mutableStateOf(Color.White) }
    var showMenu by remember { mutableStateOf(false) }

    // Container for background color
    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(backgroundColor)
    ) {
        // Text with click listener to show the menu
        Text(
            text = "Change Color",
            modifier = Modifier
                .clickable { showMenu = true }
        )

        // Dropdown menu
        DropdownMenu(
            expanded = showMenu,
            onDismissRequest = { showMenu = false }
        ) {
            // Menu items to change background color
            DropdownMenuItem(onClick = { backgroundColor = Color.Red; showMenu = false }) {
                Text("Red")
            }
            DropdownMenuItem(onClick = { backgroundColor = Color.Green; showMenu = false }) {
                Text("Green")
            }
            DropdownMenuItem(onClick = { backgroundColor = Color.Blue; showMenu = false }) {
                Text("Blue")
            }
        }
    }
}
